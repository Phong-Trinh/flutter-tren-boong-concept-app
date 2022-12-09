import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/otp/otp_bloc.dart';

import '../../../domain/bloc/authentication/authentication_bloc.dart';
import '../../../domain/bloc/authentication/authentication_event.dart';
import '../../../domain/bloc/otp/otp_event.dart';
import '../../../utility/save_data.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    Key? key,
  }) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  bool enableBtn = false;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  List<String> inputCode = ['', '', '', ''];

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FocusNode!.dispose();
    pin3FocusNode!.dispose();
    pin4FocusNode!.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 60,
                child: TextFormField(
                  autofocus: true,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    inputCode[0] = value;
                    nextField(value, pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                    focusNode: pin2FocusNode,
                    obscureText: true,
                    style: const TextStyle(fontSize: 24),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: otpInputDecoration,
                    onChanged: (value) {
                      inputCode[1] = value;
                      nextField(value, pin3FocusNode);
                    }),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    inputCode[2] = value;
                    nextField(value, pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: 60,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  obscureText: true,
                  style: const TextStyle(fontSize: 24),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: otpInputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      inputCode[3] = value;
                      pin4FocusNode!.unfocus();
                      // Then you need to check is the code is correct or not
                      setState(() {
                        enableBtn = true;
                      });
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(122, 0, 0, 0),
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: enableBtn
                  ? () {
                      print(getOtpString());
                      context.read<OtpBloc>().add(ConfirmOtp(getOtpString()));
                    }
                  : null,
              child: const SizedBox(
                  height: 40,
                  child: Center(
                      child: Text('Xác thực', textAlign: TextAlign.center))))
          // () {
          //   return null;
          //   // context
          //   //     .read<AuthenticationBloc>()
          //   //     .add(LoginByPhoneNumberEvent(SaveData.userPhoneNumb));
          // })
        ],
      ),
    );
  }

  final otpInputDecoration = const InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 15),
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(),
  );

  String getOtpString() {
    String code = '';
    for (var element in inputCode) {
      code += element;
    }
    return code;
  }
}
