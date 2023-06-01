import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
class CartScreen extends StatefulWidget {
 // final String id;
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  const Text('Cart Page '),
        centerTitle: true,
        actions: const [
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Badge(
                badgeContent: Text('0',style: TextStyle(color: Colors.white),),
                child: Icon(Icons.shopping_bag_outlined),
              ),
            ),
          ),
        ],
      ) ,
    );
  }
}
