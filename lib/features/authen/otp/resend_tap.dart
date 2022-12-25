import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/bloc/otp/otp_bloc.dart';
import '../../../domain/bloc/otp/otp_event.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class resendTap extends StatefulWidget {
  bool resendEnable;
  final List<TextEditingController> inputControllers;

  resendTap(
      {super.key, required this.resendEnable, required this.inputControllers});

  @override
  State<resendTap> createState() => _resendTapState();
}

class _resendTapState extends State<resendTap> {
  Widget build(BuildContext context) {
    //child reusable widget
    return Visibility(
        visible: widget.resendEnable,
        child: GestureDetector(
          onTap: () {
            resetOtpFields(context.read<OtpBloc>());
            setState(() {
              widget.resendEnable = false;
            });
          },
          child: Text(
            AppLocalizations.of(context)!.reSend,
            style: TextStyle(decoration: TextDecoration.underline, height: 2),
          ),
        ));
  }

  void resetOtpFields(OtpBloc otpBloc) {
    for (var element in widget.inputControllers) {
      element.clear();
    }
    otpBloc.add(ResendOtp());
  }
}
