import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Otp_Form extends StatefulWidget {
  const Otp_Form({super.key});

  @override
  State<Otp_Form> createState() => _Otp_FormState();
}

class _Otp_FormState extends State<Otp_Form> {
  int secondsRemaining = 30;
  bool enableResend = false;
  Timer? timer;
  @override
  initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mã xác thực OTP", style: TextStyle(fontSize: 25)),
      ),
      body: SafeArea(
        child: Form(
            child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // i need to bring phonenumber has entered in here
              Text("Điền OTP vừa được gửi đến số điện thoại:  ",
                  style: TextStyle(fontSize: 15)),
              // Text("$phoneNumber",
              // style: TextStyle(fontSize: 15)),
              OtpTextField(
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                numberOfFields: 5,
                borderColor: Color(0xFF512DA8),
                showFieldAsBox: false,
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                onSubmit: (String verificationCode) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Verification Code"),
                          content: Text('Code entered is $verificationCode'),
                        );
                      });
                }, // end of submit
              ),
              Expanded(child: Container()),
              Text("Gửi lại OTP sau ($secondsRemaining) giây "),
              Expanded(child: Container()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent[200],
                      // minimumSize: const Size.fromHeight(50), // NEW
                    ),
                    onPressed: enableResend ? _resendCode : null,
                    child: Text("Gửi lại OTP"),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent[200],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Tiếp tục"),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 30;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer?.cancel();
    super.dispose();
  }
}
