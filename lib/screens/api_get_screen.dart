import 'package:firebase_practice/model/postsModel.dart';
import 'package:flutter/material.dart';

import '../api_services/api_services.dart';

class ApiGetScreen extends StatefulWidget {
  const ApiGetScreen({Key? key}) : super(key: key);

  @override
  State<ApiGetScreen> createState() => _ApiGetScreenState();
}

class _ApiGetScreenState extends State<ApiGetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Api Response"),
      ),
      body: FutureBuilder(
        future: getPost(),builder: (context,AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return const Center(
              child:CircularProgressIndicator() ,
            );
          }else{
            List<Product> product = snapshot.data;

            return ListView.builder(
              itemCount: product.length,
                itemBuilder: (context,index){
                  return  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ListTile(
                        leading: Image.network(
                          product[index].thumbnail,
                              width: 100,
                        ),
                        title:  Text(product[index].title),
                        subtitle: Row(
                          children:  [
                            Expanded(
                                child: Text(product[index].description),
                            ),
                           Padding(
                             padding: EdgeInsets.all(8.0),
                             child: Text(product[index].price.toString()),
                           ),
                          ],
                        ),
                      ),
                    ),

                  );
                }
            );

          }

      },
      ),
    );
  }
}
