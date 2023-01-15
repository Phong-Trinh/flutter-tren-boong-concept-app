import 'package:flutter/material.dart';

class NewsDate extends StatelessWidget {
  final String date;
  final IconData icon;

  const NewsDate({super.key, required this.date, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        child: Row(
          children: [
            Text(date,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    wordSpacing: 1.6,
                    fontSize: 16))
          ],
        ));
  }
}
