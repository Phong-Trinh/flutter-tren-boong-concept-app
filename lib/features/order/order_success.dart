import 'package:flutter/material.dart';
import '../../utility/save_data.dart';
import 'home_button.dart';
import 'order_result.dart';

class OrderSuccess extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  const OrderSuccess(
      {super.key, required this.screenWidth, required this.screenHeight});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 170,
          padding: EdgeInsets.all(35),
          decoration: BoxDecoration(
            color: themeColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            "assets/image/card.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(height: screenHeight * 0.1),
        Text(
          "Cảm ơn bạn",
          style: TextStyle(
            color: themeColor,
            fontWeight: FontWeight.w600,
            fontSize: 36,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          "Thanh toán thành công",
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.w400,
            fontSize: 17,
          ),
        ),
        SizedBox(height: screenHeight * 0.05),
        Text(
          "Đơn hàng đã được ghi nhận và sẽ có trong giây lát, trở lại trang chủ để trải nghiệm những tính năng thú vị khác",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          ),
        ),
        SizedBox(height: screenHeight * 0.06),
        Flexible(
            child: HomeButton(
          title: 'Trang chủ',
          onTap: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
        ))
      ],
    );
  }
}
