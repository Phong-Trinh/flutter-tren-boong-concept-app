import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../infrastructure/repository/user_repository.dart';
import '../../../utility/save_data.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  //pass value to state to reponse to UI

  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginInitialState()) {
    on<CheckLoginEvent>(checkUserEvent);
    on<LoginByPhoneNumberEvent>(fetchUserEvent);
  }

  final UserRepository _userRepository;

  Future<void> fetchUserEvent(
      LoginByPhoneNumberEvent event, Emitter<AuthenticationState> state) async {
    emit(LoginLoadingState());
    var user = await _userRepository.fetchUserByPhoneNumber(event.phoneNumb);
    try {
      if (user != null) {
        SaveData.userId = user.id;
        emit(AuthenticatedState(user));
      }
    } catch (e) {
      emit(UnauthenticatedState());
    }
  }

  FutureOr<void> checkUserEvent(
      CheckLoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoginLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    var user = _userRepository.fetchAlreadyUser();
    if (user == null) {
      emit(UnauthenticatedState());
    } else {
      SaveData.userId = user.id;
      emit(AuthenticatedState(user));
    }
  }
}
