import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class ConfirmOtp extends OtpEvent {
  final String otpCode;

  ConfirmOtp(this.otpCode);
}

class RequestOtp extends OtpEvent {}

class ResendOtp extends OtpEvent {}
