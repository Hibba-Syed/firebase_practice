import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_practice/utilis/functions.dart';
import 'package:firebase_practice/notification/notifications_service.dart';
import 'package:firebase_practice/widget/increment_widget.dart';
import 'package:flutter/material.dart';

import 'Product_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  NotificationServices notificationServices = NotificationServices();
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String?  mtoken = "";
  @override
  void initState() {
    super.initState();
    notificationServices.requestNotificationPermission();
    getDeviceToken();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    // notificationServices.getDeviceToken().then((value){
    //   print("device token");
    //   print("value");
    // });
  }
  // collection use for adding data in firebase
  final firestore = FirebaseFirestore.instance.collection("products");
  // snapshots use for fetching data from firebase
  final firestores = FirebaseFirestore.instance.collection("products").snapshots();
  // CollectionReference use for updating and deleting data from firebase
  CollectionReference Reference = FirebaseFirestore.instance.collection("products");
  var price = TextEditingController();
  var name = TextEditingController();
  var quantity = TextEditingController();
  var selectedNumber = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children:  [
            70.sh,
            const Text("Add data",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            20.sh,
            TextField(
              controller: name,
              decoration: const InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
              ),
            ),
            20.sh,
            TextField(
              controller: quantity,
              decoration: const InputDecoration(
                hintText: "Quantity",
                border: OutlineInputBorder(),
              ),
            ),
            20.sh,
            TextField(
              controller: price,
              decoration: const InputDecoration(
                hintText: "Price",
                border: OutlineInputBorder(),
              ),
            ),
            20.sh,
            ElevatedButton(
                onPressed: (){
                  // this line use for generate id by yourself not auto generated this is optional
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  firestore.doc().set({
                   "name": name.text.toString(),
                    "price": price.text.toString(),
                    "id": id,
                    "quantity": quantity.text.toString()
                  }).
                  then((value){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data add successfully")));
                  }).onError((error, stackTrace){
                    // message
                    ScaffoldMessenger.of(context).showSnackBar
                      ( SnackBar( content: Text(error.toString())));
                  });
                  name.clear();
                  price.clear();
                  quantity.clear();
                  FocusScope.of(context).unfocus();
                },
                child: const Text("Add"
                ),
            ),
       // for fetching the date from firebase
            20.sh,
            const Text("Fetch data",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            StreamBuilder<QuerySnapshot>(
                stream: firestores,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const CircularProgressIndicator();
                  }
                  if(snapshot.hasError) {
                    return const Text("Something wrong");
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context,index){
                        final result = snapshot.data!.docs[index];
                          return  Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              color: Colors.purple,
                              child: const Icon(Icons.delete),
                            ),
                            // secondaryBackground:  Container(
                            //   color: Colors.amber,
                            //   child: const Icon(Icons.delete),
                            // ),
                            onDismissed: (v){
                              showDialog(context: context,
                                builder: (context)=>
                                    AlertDialog(
                                      title: const Text("Really ?"),
                                      content:  const Text("are you sure you want to delete"),
                                      actions: [
                                        TextButton(
                                            onPressed: (){
                                               deleteData(result.id);
                                               Navigator.pop(context);
                                            },
                                            child: const Text("Yes")
                                        ),
                                        TextButton(
                                            onPressed: (){
                                              Navigator.of(context).pop(false);
                                            },
                                            child: const Text("No")
                                        ),
                                      ],
                                    ),
                              );
                            //  deleteData(result.id);
                            },

                            child: Card(
                              child: ExpansionTile(
                                  title: Text("${result["name"]}"),
                                leading: IconButton(
                                  onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) =>
                                         Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(6)
                                          ),
                                           child: Padding(
                                             padding: const EdgeInsets.symmetric(horizontal: 8),
                                             child: Column(
                                               mainAxisSize: MainAxisSize.min,
                                               children: [
                                                 15.sh,
                                                 const Text("Update Details"),
                                                 20.sh,
                                                 TextField(
                                                   controller: name,
                                                   decoration: InputDecoration(
                                                     isDense: true,
                                                     filled: true,
                                                     labelText: "${result["name"]}",
                                                     border: OutlineInputBorder(
                                                         borderSide: const BorderSide(
                                                             width: 0, style: BorderStyle.none),
                                                       borderRadius: BorderRadius.circular(10)
                                                     ),

                                                   ),
                                                 ),
                                                 20.sh,
                                                 TextField(
                                                   controller: quantity,
                                                   decoration: InputDecoration(
                                                     isDense: true,
                                                     filled: true,
                                                     labelText: "quantity  ${result["quantity"]}",
                                                     border: OutlineInputBorder(
                                                         borderSide: const BorderSide(
                                                             width: 0, style: BorderStyle.none),
                                                         borderRadius: BorderRadius.circular(10)
                                                     ),

                                                   ),
                                                 ),
                                                 20.sh,
                                                 TextField(
                                                   controller: price,
                                                   decoration: InputDecoration(
                                                     isDense: true,
                                                     filled: true,
                                                     labelText: "price   ${result["price"]}",
                                                     border: OutlineInputBorder(
                                                         borderSide: const BorderSide(
                                                             width: 0, style: BorderStyle.none),
                                                         borderRadius: BorderRadius.circular(10)
                                                     ),

                                                   ),
                                                 ),
                                                 20.sh,
                                                 Row(
                                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                   children: [
                                                     SizedBox(
                                                       child: ElevatedButton(
                                                           onPressed: (){
                                                          updateData(
                                                              result.id,
                                                              name.text.toString(),
                                                              price.text.toString(),
                                                              quantity.text.toString()).then((value){
                                                            FocusScope.of(context).unfocus();
                                                            Navigator.pop(context);
                                                          });
                                                           },
                                                           child: const Text("update"),

                                                       ),
                                                     ),
                                                     SizedBox(
                                                       child: ElevatedButton(
                                                         onPressed: (){
                                                           Navigator.pop(context);
                                                         },
                                                         child: const Text("cancel"),
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                                 20.sh,
                                               ],
                                             ),
                                           ),
                                        ),
                                );
                                  },
                                  icon: const Icon(Icons.edit),

                                ),
                                children:  [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text("quantity  ${result["quantity"]}"),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Text("price   ${result["price"]}"),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                    ),
                  );
                },
            ),
            20.sh,
            Text("Selected Number: $selectedNumber",
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
            20.sh,
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>const ProductScreen()));
              showDialog(
                context: context,
                builder: (_)=>  AlertDialog(
                  title: const Text("Select a number "),
                  content: IncrementWidget(
                      initialVale: selectedNumber,
                      min: 0,
                      max: 10,
                      step: 1,
                      onChanged: (value){
                        setState(() {
                          selectedNumber = value;
                          print("num + $selectedNumber");
                        });
                      }
                  ),
                ),
              );
            },
              child: const Text("Add Quantity"),
            ),
            30.sh,
          ],
        ),
      ),
    );
  }
  //this function is use for get device token
  void getDeviceToken()async{
    await messaging.getToken().then((token){
      setState(() {
        mtoken = token;
        print("my token is  + $mtoken");
      });
    //  saveToken(token!);
    });
  }
}






