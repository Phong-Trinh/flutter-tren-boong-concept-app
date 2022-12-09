import 'dart:async';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../infrastructure/repository/user_repository.dart';
import '../../../utility/save_data.dart';
import '../../entity/user_entity.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  //pass value to state to reponse to UI
  late UserEntity? user;

  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginInitialState()) {
    on<CheckLoginEvent>(checkUserLoginBeforeEvent);
    on<LoginByPhoneNumberEvent>(fetchUserEvent);
  }

  final UserRepository _userRepository;

  Future<void> fetchUserEvent(
      LoginByPhoneNumberEvent event, Emitter<AuthenticationState> state) async {
    emit(LoginLoadingState());
    user = await _userRepository.fetchUserByPhoneNumber(event.phoneNumb);
    try {
      if (user != null) {
        SaveData.userId = user!.id;
        emit(AuthenticatedState(user!));
      }
    } catch (e) {
      emit(const UnauthenticatedState(false));
    }
  }

  Future<void> checkUserLoginBeforeEvent(
      CheckLoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoginLoadingState());
    await Future.delayed(const Duration(seconds: 1));
    var user = await _userRepository.fetchAlreadyUser();
    //test
    //var user = UserEntity(id: '1', name: 'Phong', phoneNumber: '0855556532');
    if (user == null) {
      emit(const UnauthenticatedState(false));
    } else {
      SaveData.userId = user.id;
      emit(AuthenticatedState(user));
    }
  }
}
