import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../infrastructure/repository/user_repository.dart';
import '../../../infrastructure/remote_source/api_constant.dart';
import '../../../utility/save_data.dart';
import '../../entity/image_entity.dart';
import '../../entity/user_entity.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';
import 'package:http/http.dart' as http;

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  //pass value to state to reponse to UI
  late UserEntity? user;

  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginInitialState(null)) {
    on<CheckLoginEvent>(checkUserLoginBeforeEvent);
    on<LoginByPhoneNumberEvent>(fetchUserEvent);
    on<UpdateDataUser>(updateUserEvent);
    on<UpdateAvataUser>(updateAvatarEvent);
  }
  final UserRepository _userRepository;

  Future<void> fetchUserEvent(
      LoginByPhoneNumberEvent event, Emitter<AuthenticationState> state) async {
    emit(LoginLoadingState(null));
    var user = await _userRepository.fetchUserByPhoneNumber(event.phoneNumb);
    try {
      if (user != null) {
        SaveData.userId = user!.id;
        emit(AuthenticatedState(user!));
      }
    } catch (e) {
      emit(UnauthenticatedState(null));
    }
  }

  Future<void> checkUserLoginBeforeEvent(
      CheckLoginEvent event, Emitter<AuthenticationState> emit) async {
    emit(LoginLoadingState(null));
    await Future.delayed(const Duration(seconds: 1));
    //var user = await _userRepository.fetchAlreadyUser();
    //test
    var user = UserEntity(
        id: '1',
        firstName: 'ưefwef',
        lastName: 'qưdwd',
        phoneNumber: '0855556532');
    if (user == null) {
      emit(UnauthenticatedState(null));
    } else {
      SaveData.userId = user.id;
      emit(AuthenticatedState(user));
    }
  }

  Future<void> updateUserEvent(
      UpdateDataUser event, Emitter<AuthenticationState> emit) async {
    final response = await http.put(
      Uri.parse('${ApiConstant.baseUrl}/app-users/${state.user?.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(event.user.toJson()),
    );
  }

  Future<void> updateAvatarEvent(
      UpdateAvataUser event, Emitter<AuthenticationState> emit) async {
    await Future.delayed(const Duration(seconds: 7)).then((value) async {
      try {
        print("Spam ${event.nameImage}");
        var url = Uri.parse(
            '${ApiConstant.baseUrl}/upload/files?filters[name][\$eq]=${event.nameImage}');
        var response = await http.get(url);

        if (response.statusCode == 200) {
          List<dynamic> parsed = jsonDecode(response.body);
          final List<ImageEntity> temp = ImageEntity.fromListJson(parsed);
          state.user!.url = temp[0].url;

          final responses = await http.put(
            Uri.parse('${ApiConstant.baseUrl}/app-users/${state.user?.id}'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(state.user!.toJson()),
          );
        }
      } catch (e) {
        print(e.toString());
      }
    });
  }
}
