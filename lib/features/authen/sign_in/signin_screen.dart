import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../domain/bloc/authentication/authentication_bloc.dart';
import '../../../domain/bloc/authentication/authentication_event.dart';
import '../../../domain/bloc/authentication/authentication_state.dart';
import '../../../utility/save_data.dart';
import '../otp/otp_screen.dart';
import 'gg_sign_in_btn.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
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
                  Text(AppLocalizations.of(context)!.signIn,
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
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                border: OutlineInputBorder(),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black87),
                                ),
                                hintText: (AppLocalizations.of(context)!
                                    .enterPhoneNumberHint),
                                //errorText: (""),
                              ),
                              // The validator receives the text that the user has entered.
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.length < 10 ||
                                    !value.startsWith('0')) {
                                  return AppLocalizations.of(context)!
                                      .pleaseEnterTheCorrectPhoneNumber;
                                }
                                return null;
                              },
                            )),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(0, 25, 0, 10),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(122, 0, 0, 0),
                                  minimumSize: const Size.fromHeight(50), // NEW
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    SaveData.userPhoneNumb = phoneNumb;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OtpScreen()),
                                    );
                                  }
                                },
                                child:
                                    Text(AppLocalizations.of(context)!.next))),
                      ],
                    ),
                  )
                ],
              ),
              Expanded(child: Container()),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(AppLocalizations.of(context)!.or),
              ),

              ///button Google Sign
              GoogleSigninButton(),
              SizedBox(height: 60)
            ],
          ),
        ));
  }
}
