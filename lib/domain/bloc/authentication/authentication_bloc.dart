import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../infrastructure/repository/user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  //pass value to state to reponse to UIgit 
  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginInitialState()) {
    on<CheckLoginEvent>(checkUserEvent);
    on<LoginByPhoneNumberEvent>(fetchUserEvent);
  }

  final UserRepository _userRepository;

  Future<void> fetchUserEvent(
      LoginByPhoneNumberEvent event, Emitter<AuthenticationState> state) async {
    await Future.delayed(const Duration(seconds: 1));
    var user = await _userRepository.fetchUserByPhoneNumber(event.phoneNumb.number);
    try {
      if (user != null) {
        print('heheh');
        emit(AuthenticatedState(user));
      }
    } catch (e) {
      print('hihihihi');
      emit(UnauthenticatedState());
    }
  }

  FutureOr<void> checkUserEvent(
      CheckLoginEvent event, Emitter<AuthenticationState> emit) async {
    await Future.delayed(const Duration(seconds: 1));
    var user = _userRepository.fetchAlreadyUser();
    if (user == null) {
      emit(UnauthenticatedState());
    } else {
      emit(AuthenticatedState(user));
    }
  }
}
