import 'package:equatable/equatable.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpGeneratingState extends OtpState {}

class OtpReadyState extends OtpState {}

class OtpSendingState extends OtpState {}

class OtpSendFailState extends OtpState {}

class OtpSuccessCheck extends OtpState {}

class OtpFailCheck extends OtpState {}
