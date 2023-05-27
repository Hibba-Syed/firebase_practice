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

Future delete(String id)async{
  await firestore.collection("products").doc(id).delete();

}
Future update(String id,name,price,quantity) async{
  await firestore.collection("products").doc(id).update({
    "name": name,
    "price":price,
    "quantity":quantity,
  });
}