import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class CheckLoginEvent extends AuthenticationEvent {}

class LoginByPhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumb;

  LoginByPhoneNumberEvent(this.phoneNumb);
}
