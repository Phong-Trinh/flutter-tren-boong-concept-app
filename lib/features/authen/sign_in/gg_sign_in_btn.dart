import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../domain/bloc/authentication/authentication_bloc.dart';
import '../../../domain/bloc/authentication/authentication_event.dart';
import '../../../utility/save_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GoogleSigninButton extends StatefulWidget {
  GoogleSigninButton({super.key});

  @override
  State<GoogleSigninButton> createState() => _GoogleSigninButtonState();
}

class _GoogleSigninButtonState extends State<GoogleSigninButton> {
  GoogleSignInAccount? _currentUser;
  String _contactText = '';

  @override
  void initState() {
    super.initState();
    _handleSignOut();
    SaveData.googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) {
      context
          .read<AuthenticationBloc>()
          .add(LoginByGoogleEvent(account!.email));
      setState(() {
        _currentUser = account;
      });
    });
    SaveData.googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await SaveData.googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  Future<void> _handleSignOut() => SaveData.googleSignIn.disconnect();

  Widget _buildBody() {
    return OutlinedButton(
        onPressed: _handleSignIn,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Image(
                    image: AssetImage("assets/icon/google-icon.png"),
                    height: 25.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      AppLocalizations.of(context)!.signInWithGoogle,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }
}
