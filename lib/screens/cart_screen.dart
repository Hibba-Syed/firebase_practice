import 'package:flutter/material.dart';
class CartScreen extends StatefulWidget {
  final String id;
  const CartScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:AppBar(
        title:  Text('Cart Page ${widget.id}'),
      ) ,
    );
  }
}
