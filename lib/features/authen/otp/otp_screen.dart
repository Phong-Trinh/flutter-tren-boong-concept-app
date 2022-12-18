import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/otp/otp_bloc.dart';
import '../../../domain/bloc/authentication/authentication_bloc.dart';
import '../../../domain/bloc/otp/otp_event.dart';
import '../../../domain/bloc/otp/otp_state.dart';
import '../../../infrastructure/repository/user_repository.dart';
import '../../../utility/formater.dart';
import '../../../utility/save_data.dart';
import 'otp_form.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  void initState() {
    waitOtpSend();
    super.initState();
  }

  waitOtpSend() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("Mã xác thực OTP", style: TextStyle(color: Colors.black)),
        ),
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(right: 15, left: 15, top: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "assets/image/logo.png",
                    width: 250,
                    height: 130,
                  ),
                  // const SizedBox(height: 10),
                  // const Text(
                  //   "Xác nhận mã OTP",
                  //   style: TextStyle(
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.black,
                  //     height: 1.5,
                  //   ),
                  // ),
                  Text("Điền OTP vừa được gửi đến: " +
                      Formater.hidePhoneNumbFormat(SaveData.userPhoneNumb)),
                  OtpForm()
                ],
              ),
            ),
          ),
        ));
  }
}
