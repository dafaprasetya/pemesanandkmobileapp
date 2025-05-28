import 'package:flutter/material.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _Order();
  }
}

class _Order extends StatefulWidget {
  const _Order({super.key});

  @override
  State<_Order> createState() => __OrderState();
}

class __OrderState extends State<_Order> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text('Order'),
        ),
      ],
    );
  }
}