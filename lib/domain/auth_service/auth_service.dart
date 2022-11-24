import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tren_boong_concept/features/home/home.dart';

import '../../features/authen/sign_in/signin_screen.dart';
import '../../main.dart';

class AuthService {
  //1. handleAuthState()
  //2. signInWithGoogle()
  //3. signOut()

  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Login_Screen();
          } else {
            return HomePage();
          }
        });
  }

  signInWithGoogle() async {
    //trigger the authentication flow
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>["email"]).signIn(); //googleSignIn
    //obtain the auth details form the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  singOut() {
    FirebaseAuth.instance.signOut();
  }
}
