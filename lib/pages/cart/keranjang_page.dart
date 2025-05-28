import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Cart();
  }
}

class _Cart extends StatefulWidget {
  const _Cart({super.key});

  @override
  State<_Cart> createState() => __CartState();
}

class __CartState extends State<_Cart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text('Cart'),
        ),
      ],
    );
  }
}