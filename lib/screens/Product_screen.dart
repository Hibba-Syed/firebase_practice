import 'package:badges/badges.dart';
import 'package:firebase_practice/db_sqlite/db_helper.dart';
import 'package:firebase_practice/model/cart_model.dart';
import 'package:firebase_practice/provider/cart_provider.dart';
import 'package:firebase_practice/utilis/functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ProductScreen extends StatefulWidget {
 // final String id;
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  DBHelper? dbHelper = DBHelper();
  List<String> productName = ['Mango' , 'Orange' , 'Grapes' , 'Banana' , 'Chery' , 'Peach','Mixed Fruit Basket',] ;
  List<String> productUnit = ['KG' , 'Dozen' , 'KG' , 'Dozen' , 'KG' , 'KG','KG',] ;
  List<int> productPrice = [10, 20 , 30 , 40 , 50, 60 , 70 ] ;
  List<String> productImage = [
    'https://image.shutterstock.com/image-photo/mango-isolated-on-white-background-600w-610892249.jpg' ,
    'https://image.shutterstock.com/image-photo/orange-fruit-slices-leaves-isolated-600w-1386912362.jpg' ,
    'https://image.shutterstock.com/image-photo/green-grape-leaves-isolated-on-600w-533487490.jpg' ,
    'https://media.istockphoto.com/photos/banana-picture-id1184345169?s=612x612' ,
    'https://media.istockphoto.com/photos/cherry-trio-with-stem-and-leaf-picture-id157428769?s=612x612' ,
    'https://media.istockphoto.com/photos/single-whole-peach-fruit-with-leaf-and-slice-isolated-on-white-picture-id1151868959?s=612x612' ,
    'https://media.istockphoto.com/photos/fruit-background-picture-id529664572?s=612x612' ,
  ] ;
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Cart Page '),
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
          Expanded(
              child: ListView.builder(
                itemCount: productName.length,
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
                                    image: NetworkImage(productImage[index].toString()),),
                                10.sw,
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(productName[index].toString(),
                                        style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      5.sh,
                                      Text(productUnit[index].toString() + " " + r"$" + productPrice[index].toString(),
                                        style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      5.sh,
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          onTap: (){
                                        dbHelper!.insert(
                                            CartModel(
                                                id: index,
                                                productId: index.toString(),
                                                productName: productName[index].toString(),
                                                initialPrice: productPrice[index],
                                                quantity: 1,
                                                image: productImage[index].toString(),
                                                unitTag: productUnit[index].toString(),
                                                productPrice: productPrice[index],),
                                        ).then((value){
                                          print('product is add to cart ');
                                          cart.addTotalPrice(double.parse(productPrice[index].toString()));
                                          cart.addCounter();

                                        }).onError((error, stackTrace) {
                                          print(error.toString());

                                        });
                                          },
                                          child: Container(
                                            height: 35,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            child: const Center(child: Text('Add to cart',
                                              style: TextStyle(color: Colors.white),
                                            )),
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
          ),
        ],
      ),
    );
  }
}
