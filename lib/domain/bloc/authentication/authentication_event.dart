import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:tren_boong_concept/domain/entity/user_entity.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class CheckLoginEvent extends AuthenticationEvent {}

class LoginByPhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumb;
  LoginByPhoneNumberEvent(this.phoneNumb);
}

class LoginByGoogleEvent extends AuthenticationEvent {
  final String email;
  LoginByGoogleEvent(this.email);
}

class UpdateDataUser extends AuthenticationEvent {
  final UserEntity user;
  UpdateDataUser(this.user);
}

class UpdateAvataUser extends AuthenticationEvent {
  String nameImage;
  UpdateAvataUser(this.nameImage);
}

class ConfirmPhoneNumberEvent extends AuthenticationEvent {
  final String phoneNumb;

  ConfirmPhoneNumberEvent(this.phoneNumb);
}

class UpdateDeveiceFcmToken extends AuthenticationEvent {
  final String token;

  UpdateDeveiceFcmToken(this.token);
}

class SignoutUserEvent extends AuthenticationEvent {}

class UpdatePointCoinEvent extends AuthenticationEvent{
  final int point;

  UpdatePointCoinEvent(this.point);


}