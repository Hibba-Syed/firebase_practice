import 'package:firebase_practice/utilis/functions.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
class UplodeImage extends StatefulWidget {
  const UplodeImage({Key? key}) : super(key: key);

  @override
  State<UplodeImage> createState() => _UplodeImageState();
}

class _UplodeImageState extends State<UplodeImage> {
  File? selectedImage;

  Future pickImageFromGallery() async {
    PermissionStatus permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          selectedImage = File(result.files.first.path!);
        });
      }
    } else {
      print('Storage permission denied.');
    }
  }
  Future uploadImageToFirebaseAndFirestore() async {
    if (selectedImage != null) {
      try {
        // Create a unique filename for the image
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();

        // Get a reference to the Firebase Storage location
        Reference storageReference = FirebaseStorage.instance.ref().child(fileName);

        // Upload the file to Firebase Storage
        TaskSnapshot storageTaskSnapshot = await storageReference.putFile(selectedImage!);

        // Get the download URL for the image
        String imageUrl = await storageTaskSnapshot.ref.getDownloadURL();

        // Store the image URL in Firestore
        await FirebaseFirestore.instance.collection('images').add({
          'url': imageUrl,
          'fileName': fileName,
          'timestamp': DateTime.now(),
        });

        // Display success or perform further actions
        print('Image uploaded and stored in Firestore successfully.');
      } catch (e) {
        print('Error uploading image to Firebase Storage and Firestore: $e');
      }
    } else {
      print('No image selected.');
    }
  }


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              selectedImage != null
                  ? Container(
                height: 200,
                width: 200,
                child: Image.file(selectedImage!,
                  fit: BoxFit.cover,
                ),
              ) : Container(
                child: const Text("image not found "),
              ),
              20.sh,
              ElevatedButton(
                onPressed: () {
                    pickImageFromGallery();
                },
                child: const Text("select image"),
              ),
              20.sh,
              ElevatedButton(
                onPressed: () {
                  uploadImageToFirebaseAndFirestore();
                },
                child: const Text("upload"),
              ),
            ],
          ),
        ),
      );
    }
  }




