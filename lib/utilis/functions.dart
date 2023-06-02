import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final firestore = FirebaseFirestore.instance;
Future addData(BuildContext context,String name,price,quantity) async{
  firestore.collection("products").add({
    "name": name,
    "price":price,
    "quantity":quantity,
  }).whenComplete((){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Data added successfully")));
  });
}

Future deleteData(String id)async{
  await firestore.collection("products").doc(id).delete();

}
Future updateData(String id,name,price,quantity) async{
  await firestore.collection("products").doc(id).update({
    "name": name,
    "price":price,
    "quantity":quantity,
  });
}
// this function use for sizeBox size
extension Size on  num{
  SizedBox get sh => SizedBox(height: toDouble(),);
  SizedBox get sw => SizedBox(width: toDouble(),);
}