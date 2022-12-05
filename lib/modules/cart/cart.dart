// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';


class Cart_Screen extends StatelessWidget {
  const Cart_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Cart',style:TextStyle(fontSize: 22.0)),
      ),
    );
  }
}