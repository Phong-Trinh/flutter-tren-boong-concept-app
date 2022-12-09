import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../infrastructure/repository/user_repository.dart';
import '../../../utility/save_data.dart';
import '../authentication/authentication_bloc.dart';
import '../authentication/authentication_event.dart';
import 'otp_event.dart';
import 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  //pass value to state to reponse to UI
  final AuthenticationBloc _authBloc;
  final UserRepository _userRepository;
  late String otpCode = '';

  OtpBloc(
      {required UserRepository userRepository,
      required AuthenticationBloc authBloc})
      : _authBloc = authBloc,
        _userRepository = userRepository,
        super(OtpGeneratingState()) {
    on<RequestOtp>(sendOtpToUser);
    on<ConfirmOtp>(checkOtpUserConfirm);
  }

  Future<void> sendOtpToUser(RequestOtp event, Emitter<OtpState> emit) async {
    //send otp va emit statement
    otpCode = generateOtpCode();
    bool isSuccessSend = await _userRepository.sendOtpToUser(
        _authBloc.user!.phoneNumber, otpCode);
    if (isSuccessSend) {
      emit(OtpReadyState());
    } else {
      emit(OtpSendFailState());
    }
  }

  Future<void> checkOtpUserConfirm(
      ConfirmOtp event, Emitter<OtpState> emit) async {
    // check user's otp neu sai thi emit dugn thi goi authenBloc handle
    if (event.otpCode == '1234') {
      _authBloc.add(LoginByPhoneNumberEvent(SaveData.userPhoneNumb));
    } else {
      emit(OtpFailCheck());
    }
  }

  String generateOtpCode() {
    String otp = '';
    List<int> list = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
    final random = Random();
    for (var i in [1, 2, 3, 4]) {
      otp += list[random.nextInt(list.length)].toString();
    }
    return otp;
  }
}
