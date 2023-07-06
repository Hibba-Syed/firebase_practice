import 'dart:convert';

import 'package:firebase_practice/model/student_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
class MianPageApi extends StatefulWidget {
  const MianPageApi({Key? key}) : super(key: key);

  @override
  State<MianPageApi> createState() => _MianPageApiState();
}

class _MianPageApiState extends State<MianPageApi> {
 // using this function for loading the json from assets
 Future<Student?> loadAsset() async {
    var loadJson = await rootBundle.loadString('json_data/student_json.json');
  var jsonDecode = await json.decode(loadJson);
    Student student = Student.fromJson(jsonDecode);
    //print(student.mit[0].studentName);
    return student;

  }
  @override
  void initState() {
    loadAsset();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
   body: FutureBuilder(
     future:loadAsset() ,
     builder: (context, AsyncSnapshot<Student?> snapshot){
       final result = snapshot.data!;
       if(!snapshot.hasData){
         return const Center(child: CircularProgressIndicator(),);
       }
       return Padding(
         padding: const EdgeInsets.only(top: 40),
         child: SingleChildScrollView(
           child: Column(
             children: [
                const Text("Images",style: TextStyle(fontSize: 20),),
               ...List.generate(result.images!.length, (index) {
                 return
                   Card(
                     color: Colors.pink,
                     child: ListTile(
                       title: Text("${result.images[index].image}",style: const TextStyle(color: Colors.white),),
                     ),
                   );
               }),
               const Text("Attributes",style: TextStyle(fontSize: 20),),
             Card(
               color: Colors.green,
               child: ListTile(
                 title: Text("${result.attribute.color}",style: const TextStyle(color: Colors.white)),
               ),
             ),
               const Text("Subjects",style: TextStyle(fontSize: 20),),
               ...List.generate(result.subject.length, (index){
                 return Card(
                   color: Colors.purple,
                   child: ListTile(
                     title: Text("${result.subject[index]}",style: const TextStyle(color: Colors.white)),
                   ),
                 );
               }),

              const Text("User Profile",style: TextStyle(fontSize: 20),),
               Card(
                 color: Colors.amber,
                 child: ListTile(
                   title: Text("${result.name}",style: const TextStyle(color: Colors.white)),
                 ),
               ),
               Card(
                 color: Colors.amber,
                 child: ListTile(
                   title: Text("${result.age}",style: const TextStyle(color: Colors.white)),
                 ),
               ),
               Card(
                 color: Colors.amber,
                 child: ListTile(
                   title: Text("${result.rollNo}",style: const TextStyle(color: Colors.white)),
                 ),
               ),
             ],
           ),
         ),
       );
     },
   ),
    );
  }
}
