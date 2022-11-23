import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/authentication/authentication_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/bloc/authentication/authentication_event.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
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
              SizedBox(height: 50),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Đăng nhập',
                        style: GoogleFonts.titilliumWeb(
                            fontSize: 18, fontWeight: FontWeight.w700)),
                    SizedBox(height: 5),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: double.infinity,
                              child: TextFormField(
                                onChanged: (text) {
                                  this.phoneNumb = text;
                                },
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  border: OutlineInputBorder(),
                                  hintText: ("Nhập số điện thoại"),
                                ),
                                // The validator receives the text that the user has entered.
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Vui lòng nhập đúng số điện thoại';
                                  }
                                  return null;
                                },
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black12,
                                    minimumSize:
                                        const Size.fromHeight(50), // NEW
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      context.read<AuthenticationBloc>().add(
                                          LoginByPhoneNumberEvent(phoneNumb));
                                    }
                                  },
                                  child: Text("Next"))),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Checkbox(
                            shape: CircleBorder(),
                            value: isChecked,
                            onChanged: (k) {
                              setState(() {
                                isChecked = !isChecked;
                              });
                            }),
                        SizedBox(width: 5),
                        Flexible(
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
              ),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text("Or"),
                ),
              ),

              ///button Google Sign
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Container(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.android,
                      size: 24,
                    ),
                    label: Text(
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
