import 'dart:convert';

import 'package:firebase_practice/model/postsModel.dart';
import 'package:http/http.dart' as http;


var base= "https://dummyjson.com";
getPost()async{
  Uri url = Uri.parse("$base/products");
  var res =  await http.get(url);
  try{
    print('Response Status Code: ${res.statusCode}');
    print('Response Body: ${res.body}');
    if(res.statusCode == 200){
      var data= postsModelFromJson(res.body);
      return data.products;
    }
    else{
   print("Error during connection");
    }
  }catch(e){
    print(e.toString());
  }
}

postData()async{
  Uri url = Uri.parse("$base/products/add");
  var data = {
    'title': "Laptop",
    'price': 300.toString(),
  };
 // use headers if require in server
  // var headers ={
  //   'content-type': 'application/jason'
  // };
  //var post = http.post(url,body: data,headers: headers);
  var post = await http.post(url,body: data,);
 try{
   if(post.statusCode == 200){
     var jsonData = jsonDecode(post.body);
     print(jsonData);
     print("Data post Successfully");
   }else{
     print('error during posting data');
   }
 }catch(e){
   print(e.toString());
 }
}