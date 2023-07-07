import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/detail_user.dart';


class RandomUser extends StatefulWidget {
  const RandomUser({Key? key}) : super(key: key);

  @override
  State<RandomUser> createState() => _RandomUserState();
}

class _RandomUserState extends State<RandomUser> {


  var base= "https://randomuser.me/api";
  getPost()async{
    Uri url = Uri.parse("$base/?results");
    var response =  await http.get(url);
    try{
      // print('Response Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');
     var json = jsonDecode(response.body);
      DetailUser detailUser = DetailUser.fromJson(json);
      print(detailUser.results![0].name!.first);
      return detailUser;

    }catch(e){
      print(e.toString());
    }
  }
  // List<dynamic> users = [];
  //
  // var base= "https://randomuser.me/api";
  // Future getPost() async {
  //   Uri url = Uri.parse("$base/?results=3");
  //   var response = await http.get(url);
  //
  //   // print('Response Status Code: ${response.statusCode}');
  //   // print('Response Body: ${response.body}');
  //   var json = jsonDecode(response.body);
  //   final results = json['results'] as List<dynamic>;
  //   users = results.map((e) {
  //     return DetailUser.fromJson(e);
  //   }).toList();
  //   print(users!.length);
  // }

  @override
  void initState() {
  getPost();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getPost(),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          DetailUser detailUser = snapshot.data!;
          List<Results>? results = detailUser.results;
          return ListView.builder(
            itemCount: results!.length,
            itemBuilder: (context, index) {
              final user = results![index];
              print(user.name!.first);
              return ListTile(
                  leading: Image.network(user.picture?.thumbnail ?? ''),
                  title: Text(
                      '${user.name?.first ?? ''} ${user.name?.last ?? ''}'),
                  subtitle: Text(user.email ?? ''),
                trailing: Text(user.location!.country ?? ''),
              );
            },
          );
        }),

    );
    }

}

