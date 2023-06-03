import 'package:badges/badges.dart';
import 'package:firebase_practice/utilis/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../db_sqlite/db_helper.dart';
import '../model/cart_model.dart';
import '../provider/cart_provider.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DBHelper? dbHelper = DBHelper();
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:  const Text('My Cart products '),
        centerTitle: true,
        actions:  [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Badge(
                badgeContent: Consumer<CartProvider>(
                  builder: (context, value, child){
                    return  Text(value.getCounter().toString(),style: TextStyle(color: Colors.white));
                  },
                ),
                child: const Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
        ],
      ) ,
      body: Column(
        children: [
          FutureBuilder(
            future: cart.getData(),
              builder: (context,AsyncSnapshot<List<CartModel>> snapshot){
              if(snapshot.hasData){
                return Expanded(
                    child:ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context,index){
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Image(
                                        height:100,
                                        width: 100,
                                        image: NetworkImage(snapshot.data![index].image.toString()),),
                                      10.sw,
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(snapshot.data![index].productName.toString(),
                                                  style: TextStyle(fontSize: 16,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                                InkWell(
                                                    onTap: (){
                                                      dbHelper?.delete(snapshot.data![index].id!);
                                                      cart.removeCounter();
                                                      cart.removeTotalPrice(double.parse(snapshot.data![index].productPrice.toString()));


                                                  },
                                                    child: const Icon(Icons.delete))
                                              ],
                                            ),
                                            5.sh,
                                            Text(snapshot.data![index].unitTag.toString() + " " + r"$" + snapshot.data![index].productPrice.toString(),
                                              style: TextStyle(fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            5.sh,
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: InkWell(
                                                onTap: (){

                                                },
                                                child: Container(
                                                  height: 35,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(4.0),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        InkWell(
                                                            onTap: (){
                                                              int quantity = snapshot.data![index].quantity! ;
                                                              int price = snapshot.data![index].initialPrice!;
                                                              quantity--;
                                                              int? newPrice = price * quantity;
                                                              if(quantity >0){
                                                                dbHelper!.updateQuantity(
                                                                    CartModel(
                                                                        id: snapshot.data![index].id,
                                                                        productId: snapshot.data![index].id!.toString(),
                                                                        productName: snapshot.data![index].productName,
                                                                        initialPrice: snapshot.data![index].initialPrice,
                                                                        quantity: quantity,
                                                                        image: snapshot.data![index].image.toString(),
                                                                        unitTag: snapshot.data![index].unitTag.toString(),
                                                                        productPrice: newPrice)
                                                                ).then((value){
                                                                  newPrice =0;
                                                                  quantity = 0;
                                                                  cart.removeTotalPrice(double.parse(snapshot.data![index].initialPrice.toString()));
                                                                }).onError((error, stackTrace){
                                                                  print(error.toString());
                                                                } );
                                                              }

                                                            },
                                                            child: const Icon(Icons.remove,color: Colors.white,)),
                                                        Text(snapshot.data![index].quantity.toString(),
                                                          style:const  TextStyle(color: Colors.white),
                                                        ),
                                                        InkWell(
                                                          onTap: (){
                                                            int quantity = snapshot.data![index].quantity! ;
                                                            int price = snapshot.data![index].initialPrice!;
                                                            quantity++;
                                                            int? newPrice = price * quantity;
                                                            dbHelper!.updateQuantity(
                                                                CartModel(
                                                                    id: snapshot.data![index].id,
                                                                    productId: snapshot.data![index].id!.toString(),
                                                                    productName: snapshot.data![index].productName,
                                                                    initialPrice: snapshot.data![index].initialPrice,
                                                                    quantity: quantity,
                                                                    image: snapshot.data![index].image.toString(),
                                                                    unitTag: snapshot.data![index].unitTag.toString(),
                                                                    productPrice: newPrice)
                                                            ).then((value){
                                                              newPrice =0;
                                                              quantity = 0;
                                                              cart.addTotalPrice(double.parse(snapshot.data![index].initialPrice.toString()));
                                                            }).onError((error, stackTrace){
                                                              print(error.toString());
                                                            } );

                                                          },
                                                            child: const Icon(Icons.add,color: Colors.white,)),
                                                      ],

                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                );
              }
              return Text('');
              }
          ),
    Consumer<CartProvider>(builder: (context,value,child ){
    return Visibility(
      visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"? false : true,
      child: Column(
      children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ReuseableWidget(title: "Sub Total", value: r'$' + value.getTotalPrice().toStringAsFixed(2)),
      ),
      ],
      ),
    );
    }
    ),
        ],
      ),
    );
  }
}
class  ReuseableWidget extends StatelessWidget {
  final String title , value ;

  const ReuseableWidget ({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style:
          Theme.of(context).textTheme.subtitle2,),
          Text(value.toString(),style:
          Theme.of(context).textTheme.subtitle2,),

        ],
      ),
    );
  }
}