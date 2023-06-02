import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/cart_model.dart';
import '../provider/cart_provider.dart';
class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
              return Text('');
              }
          ),
        ],
      ),
    );
  }
}
