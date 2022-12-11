import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/bloc/otp/otp_bloc.dart';
import '../../../domain/bloc/otp/otp_event.dart';

class ConfirmButton extends StatefulWidget {
  bool confirmEnable;
  final List<TextEditingController> inputControllers;
  ConfirmButton(
      {super.key, required this.confirmEnable, required this.inputControllers});

  @override
  State<ConfirmButton> createState() => ConfirmButtonState();
}

class ConfirmButtonState extends State<ConfirmButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(122, 0, 0, 0),
          minimumSize: const Size.fromHeight(50), // NEW
        ),
        onPressed: widget.confirmEnable
            ? () {
                print(getOtpString());
                context.read<OtpBloc>().add(ConfirmOtp(getOtpString()));
              }
            : null,
        child: const SizedBox(
            height: 40,
            child:
                Center(child: Text('Xác thực', textAlign: TextAlign.center))));
  }

  String getOtpString() {
    String code = '';
    for (var element in widget.inputControllers) {
      code += element.text;
    }
    return code;
  }
}
