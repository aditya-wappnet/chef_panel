// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_final_fields, must_be_immutable

import 'package:chef_panel/helper/constant/styles.dart';
import 'package:chef_panel/models/order_model.dart';
import 'package:flutter/material.dart';

class OrderDetailScreen extends StatelessWidget {
  final OrderData orderData;
  const OrderDetailScreen({Key? key, required this.orderData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: titleTextStyle,
        ),
        backgroundColor: Colors.white,
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
