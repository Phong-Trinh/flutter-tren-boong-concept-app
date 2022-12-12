import 'package:equatable/equatable.dart';

import '../../entity/user_entity.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends AuthenticationState {}

class LoginLoadingState extends AuthenticationState {}

class AuthenticatedState extends AuthenticationState {
  final UserEntity user;
  const AuthenticatedState(this.user);
}

class UnauthenticatedState extends AuthenticationState {}
