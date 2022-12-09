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
  bool resendEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => OtpBloc(
                authBloc: context.read<AuthenticationBloc>(),
                userRepository: context.read<UserRepository>())
              ..add(RequestOtp()),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, top: 50),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/image/logo.png",
                        width: 250,
                        height: 130,
                      ),
                      const SizedBox(height: 10),
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
                      const OtpForm(),
                      BlocBuilder<OtpBloc, OtpState>(
                          builder: (BuildContext context, OtpState state) {
                        if (state is OtpFailCheck) return failOtpText();
                        return Container();
                      }),
                      const SizedBox(height: 100),
                      Visibility(
                          visible: resendEnable,
                          child: GestureDetector(
                            onTap: () {
                              // OTP code resend
                            },
                            child: const Text(
                              "Gửi lại",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  height: 2),
                            ),
                          )),
                      const SizedBox(height: 10),
                      buildTimer(),
                    ],
                  ),
                ),
              ),
            )));
  }

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
