import 'package:equatable/equatable.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class CheckLoginEvent extends AuthenticationEvent {}

class LoginByPhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumb;
  LoginByPhoneNumberEvent(this.phoneNumb);
}

class LoginByGoogleAccount extends AuthenticationEvent {
  final GoogleSignInAccount account;

  LoginByGoogleAccount(this.account);
}

class ConfirmPhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumb;

  ConfirmPhoneNumberEvent(this.phoneNumb);
}
