import 'package:flutter/material.dart';

import '../api_services/api_services.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          postData();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
       title: const Text("Post Api"),
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
