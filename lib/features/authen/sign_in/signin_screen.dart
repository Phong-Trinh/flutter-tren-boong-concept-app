import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/authentication/authentication_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/bloc/authentication/authentication_event.dart';
import '../../../utility/save_data.dart';
import '../otp/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  String phoneNumb = '';
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/image/logo.png",
                width: 250,
                height: 130,
              ),
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Đăng nhập',
                      style: GoogleFonts.titilliumWeb(
                          fontSize: 18, fontWeight: FontWeight.w700)),
                  const SizedBox(height: 5),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            child: TextFormField(
                              style: TextStyle(fontSize: 18),
                              onChanged: (text) {
                                phoneNumb = text;
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87),
                                ),
                                hintText: ("Nhập số điện thoại"),
                                //errorText: (""),
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 10 ||
                                    !value.startsWith('0')) {
                                  return 'Vui lòng nhập đúng số điện thoại';
                                }
                                return null;
                              },
                            )),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(123, 127, 59, 36),
                                  minimumSize: const Size.fromHeight(50), // NEW
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    SaveData.userPhoneNumb = phoneNumb;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const OtpScreen()),
                                    );
                                  }
                                },
                                child: const Text("Tiếp theo"))),
                      ],
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                          shape: const CircleBorder(),
                          value: isChecked,
                          onChanged: (k) {
                            setState(() {
                              isChecked = !isChecked;
                            });
                          }),
                      const SizedBox(width: 5),
                      const Flexible(
                        child: Text(
                          "I have read and accept the Terms of Service and Privacy Policy.",
                          overflow: TextOverflow.visible,
                          textDirection: TextDirection.ltr,
                          textAlign: TextAlign.start,
                          // maxLines: 2,
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  )
                ],
              ),
              Expanded(child: Container()),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("Or"),
              ),

              ///button Google Sign
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.android,
                      size: 24,
                    ),
                    label: const Text(
                      "Login With Google",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
