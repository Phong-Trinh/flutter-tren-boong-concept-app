import 'package:flutter/material.dart';

class PromotionDate extends StatelessWidget {
  final String date;
  final IconData icon;
  final Color textColor;
  const PromotionDate(
      {super.key,
      required this.textColor,
      required this.date,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        child: Row(
          children: [
            SizedBox(width: 20),
            Icon(icon, color: textColor),
            SizedBox(width: 8),
            Text(date,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    wordSpacing: 1.6,
                    fontSize: 16))
          ],
        ));
  }
}
