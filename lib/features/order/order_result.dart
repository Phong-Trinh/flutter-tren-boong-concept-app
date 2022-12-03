import 'package:flutter/material.dart';
import 'order_success.dart';

class OrderResult extends StatefulWidget {
  const OrderResult({super.key});

  @override
  State<OrderResult> createState() => OrderResultState();
}

late Color themeColor;

class OrderResultState extends State<OrderResult> {
  double screenWidth = 600;
  double screenHeight = 400;
  Color textColor = const Color(0xFF32567A);

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    themeColor = Color(0xFF43D19E);
    return Scaffold(
        body: Center(
            child: OrderSuccess(
                screenHeight: screenHeight, screenWidth: screenWidth)));
  }
}
