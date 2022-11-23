import 'package:equatable/equatable.dart';
import 'package:intl_phone_field/phone_number.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class CheckLoginEvent extends AuthenticationEvent {}

class LoginByPhoneNumberEvent extends AuthenticationEvent {
  final PhoneNumber phoneNumb;

  LoginByPhoneNumberEvent(this.phoneNumb);
}
