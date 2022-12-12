import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/otp/otp_bloc.dart';

import '../../../domain/bloc/authentication/authentication_bloc.dart';
import '../../../domain/bloc/authentication/authentication_event.dart';
import '../../../domain/bloc/otp/otp_event.dart';
import '../../../domain/bloc/otp/otp_state.dart';
import '../../../infrastructure/repository/user_repository.dart';
import '../../../utility/save_data.dart';
import 'confirm_button.dart';
import 'resend_tap.dart';

class OtpForm extends StatefulWidget {
  OtpForm({Key? key}) : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  bool resendEnable = false;
  bool confirmEnable = false;
  FocusNode? pin2FocusNode;
  FocusNode? pin3FocusNode;
  FocusNode? pin4FocusNode;
  List<TextEditingController> inputControllers = [
    TextEditingController(text: ''),
    TextEditingController(text: ''),
    TextEditingController(text: ''),
    TextEditingController(text: '')
  ];

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
    return BlocProvider(
        create: (context) => OtpBloc(
            authBloc: context.read<AuthenticationBloc>(),
            userRepository: context.read<UserRepository>())
          ..add(RequestOtp()),
        child: Form(
          child: Column(
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      controller: inputControllers[0],
                      obscureText: true,
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        nextField(value, pin2FocusNode);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                        controller: inputControllers[1],
                        focusNode: pin2FocusNode,
                        obscureText: true,
                        style: const TextStyle(fontSize: 24),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: otpInputDecoration,
                        onChanged: (value) {
                          nextField(value, pin3FocusNode);
                        }),
                  ),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      controller: inputControllers[2],
                      focusNode: pin3FocusNode,
                      obscureText: true,
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        nextField(value, pin4FocusNode);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    child: TextFormField(
                      controller: inputControllers[3],
                      focusNode: pin4FocusNode,
                      obscureText: true,
                      style: const TextStyle(fontSize: 24),
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: otpInputDecoration,
                      onChanged: (value) {
                        if (value.length == 1) {
                          pin4FocusNode!.unfocus();
                          // Then you need to check is the code is correct or not
                          setState(() {
                            confirmEnable = true;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ConfirmButton(
                  confirmEnable: confirmEnable,
                  inputControllers: inputControllers),
              SizedBox(height: 10),
              BlocBuilder<OtpBloc, OtpState>(
                  builder: (BuildContext context, OtpState state) {
                if (state is OtpFailCheck) return failOtpText();
                return Container();
              }),
              const SizedBox(height: 100),
              resendTap(
                  resendEnable: resendEnable,
                  inputControllers: inputControllers),
              const SizedBox(height: 10),
              BlocBuilder<OtpBloc, OtpState>(
                  builder: (BuildContext context, OtpState state) {
                if (state is OtpSendingState)
                  return CircularProgressIndicator();
                return buildTimer();
              }),
            ],
          ),
        ));
  }

  final otpInputDecoration = const InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 15),
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(),
  );

  Row buildTimer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Mã sẽ còn hiệu lực trong "),
        TweenAnimationBuilder(
          tween: Tween(begin: 30.0, end: 0.0),
          duration: const Duration(seconds: 30),
          builder: (_, dynamic value, child) => Text(
            "00:${value.toInt()}",
            style: TextStyle(color: Colors.red.shade400),
          ),
          onEnd: () {
            setState(() {
              resendEnable = true;
              confirmEnable = false;
            });
          },
        ),
      ],
    );
  }

  Text failOtpText() {
    return Text('Otp bạn nhập không đúng, vui lòng thử lại.',
        style: TextStyle(color: Colors.red.shade400));
  }
}
