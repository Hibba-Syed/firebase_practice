import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_practice/functions.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  // collection use for adding data in firebase
  final firestore = FirebaseFirestore.instance.collection("products");
  // snapshots use for fetching data from firebase
  final firestores = FirebaseFirestore.instance.collection("products").snapshots();
  // CollectionReference use for updating and deleting data from firebase
  CollectionReference Reference = FirebaseFirestore.instance.collection("products");
  var price = TextEditingController();
  var name = TextEditingController();
  var quantity = TextEditingController();
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
                              delete(result.id);
                            },

                            child: Card(
                              child: ExpansionTile(
                                  title: Text("${result["name"]}"),
                                leading: IconButton(
                                  onPressed: () {  },
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
            const Text("Update data",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              ),
            ),
            20.sh,
          ],
        ),
      ),
    );
  }
}
extension Size on  num{
 SizedBox get sh => SizedBox(height: toDouble(),);
 SizedBox get sw => SizedBox(width: toDouble(),);
}





