import 'package:equatable/equatable.dart';

import '../../entity/user_entity.dart';

abstract class AuthenticationState extends Equatable {
  final UserEntity? user;
  const AuthenticationState(this.user);

  @override
  List<Object> get props => [];
}

class LoginInitialState extends AuthenticationState {
  LoginInitialState(super.user);
}

class LoginLoadingState extends AuthenticationState {
  LoginLoadingState(super.user);
}

class AuthenticatedState extends AuthenticationState {
  final UserEntity user;
  const AuthenticatedState(this.user) : super(null);
}

class UnauthenticatedState extends AuthenticationState {
  UnauthenticatedState(super.user);
}
