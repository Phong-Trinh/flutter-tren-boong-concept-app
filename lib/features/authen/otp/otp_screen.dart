import 'package:flutter/material.dart';

import '../../../utility/formater.dart';
import '../../../utility/save_data.dart';
import 'otp_form.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15, top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                "Xác nhận mã OTP",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.5,
                ),
              ),
              Text("Mã đã được gửi đến " +
                  Formater.hidePhoneNumbFormat(SaveData.userPhoneNumb)),
              buildTimer(),
              OtpForm(),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // OTP code resend
                },
                child: const Text(
                  "Gửi lại",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Mã sẽ còn hiệu lực trong "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.red.shade400),
          ),
          onEnd: () {},
        ),
      ],
    );
  }
}
