import '../../domain/entity/user_entity.dart';
import '../remote_source/sms_service.dart';
import '../remote_source/user_service.dart';

class UserRepository {
  Future<UserEntity?> fetchUserByPhoneNumber(String phoneNumb) async {
    return await UserService.getUserByPhoneNumber(phoneNumb);
  }

  Future<UserEntity?> fetchUserByEmail(String email) async {
    return await UserService.getUserByEmail(email);
  }

  Future<UserEntity?> fetchAlreadyUser() async {
    return await UserService.getUserLogedin();
  }

  Future<bool> sendOtpToUser(String phoneNumb, String otpCode) async {
    return await SmsService.SendOtpSms(phoneNumb: phoneNumb, otpCode: otpCode);
  }

  Future<UserEntity?> createUserWithPhoneNumber(String phoneNumber) async {
    return await UserService.createUserWithPhoneNumber(phoneNumber);
  }

  Future<UserEntity?> createUserWithEmail(String email) async {
    return await UserService.createUserWithEmail(email);
  }
}
