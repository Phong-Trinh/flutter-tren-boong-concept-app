import '../../domain/entity/user_entity.dart';
import '../remote_source/sms_service.dart';
import '../remote_source/user_service.dart';

class UserRepository {
  Future<UserEntity?> fetchUserByPhoneNumber(String phoneNumb) async {
    var user = await UserService.getUserByPhoneNumber(phoneNumb);
    if (user != null) {
      UserService.saveUserLogin(user.id);
    }
    return user;
  }

  Future<UserEntity?> fetchUserByEmail(String email) async {
    var user = await UserService.getUserByEmail(email);
    if (user != null) {
      UserService.saveUserLogin(user.id);
    }
    return user;
  }

  Future<UserEntity?> fetchAlreadyUser() async {
    var user = await UserService.getUserLogedin();
    if (user != null) {
      UserService.saveUserLogin(user.id);
    }
    return user;
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

  Future<void> signOutUser() async {
    return await UserService.unsaveUserLogin();
  }
}
