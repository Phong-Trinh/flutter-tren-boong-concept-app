import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SaveData {
  static late String title;
  static late String userId;
  static late String userPhoneNumb;
  static int selectedCouponId = -1;
  static bool? isPaymentSuccess = null;
  static GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: <String>['email'],
  );
  static List<String> selectedCardProducts = [];
  static GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  static late String? fcmToken;
}
