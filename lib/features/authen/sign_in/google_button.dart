import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tren_boong_concept/domain/auth_service/auth_service.dart';

class GoogleButton extends StatelessWidget {
  GoogleButton({super.key});
  bool _isLoading = false;
  Future<void> _googleSignIn() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      try {} on FirebaseException catch (error) {
      } catch (error) {
      } finally {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: OutlinedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(35), // NEW
        ),
        onPressed: () {
          AuthService().signInWithGoogle();
        },
        icon: Icon(
          FontAwesomeIcons.google,
          color: Colors.red,
          size: 24,
        ),
        label: Text(
          "Login With Google",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
