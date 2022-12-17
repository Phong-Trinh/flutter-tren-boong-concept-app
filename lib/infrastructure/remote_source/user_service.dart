import 'dart:convert';
import '../../domain/entity/user_entity.dart';
import '../local_source/share_preferences_service.dart';
import 'api_constant.dart';
import 'package:http/http.dart' as http;

class UserService {
  static Future<UserEntity?> getUserByPhoneNumber(String phoneNumb) async {
    try {
      var url = Uri.parse(
          '${ApiConstant.baseUrl}${ApiConstant.usersEndpoint}?filters[phoneNumber][\$eq]=$phoneNumb');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        UserEntity? model = praseUsersFromJson(response.body);
        return model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<UserEntity?> getUserByEmail(String email) async {
    try {
      var url = Uri.parse(
          '${ApiConstant.baseUrl}${ApiConstant.usersEndpoint}?filters[email][\$eq]=$email');
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
        UserEntity? model = praseUsersFromJson(response.body);
        return model;
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<void> saveUserLogin(String id) async {
    try {
      await SharedPreferencesService.setUserId(id);
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<UserEntity?> getUserLogedin() async {
    String? id;
    UserEntity? user;
    try {
      id = await SharedPreferencesService.getUserId();
      user = await getUserById(id!);
    } catch (e) {
      return null;
    }
    return user;
  }

  static Future<UserEntity?> getUserById(String id) async {
    try {
      var url = Uri.parse(
          '${ApiConstant.baseUrl}${ApiConstant.usersEndpoint}?filters[id][\$eq]=$id');
      var response = await http.get(url);
      print(url);
      if (response.statusCode == 200) {
        print(response.body);
        return praseUsersFromJson(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<UserEntity?> createUserWithPhoneNumber(
      String phonenumber) async {
    try {
      var response = await sendPostUser(phonenumber, null);
      if (response.statusCode == 200) {
        print(response.body);
        return praseUserFromJson(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<UserEntity?> createUserWithEmail(String email) async {
    try {
      var response = await sendPostUser(null, email);
      if (response.statusCode == 200) {
        print(response.body);
        return praseUserFromJson(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  static Future<http.Response> sendPostUser(
      String? phonenumber, String? email) {
    return http.post(
      Uri.parse('${ApiConstant.baseUrl}/app-users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        "data": {"phoneNumber": phonenumber, "email": email}
      }),
    );
  }

  static UserEntity praseUserFromJson(String json) {
    Map<String, dynamic> parsed = jsonDecode(json);
    final user = parsed['data'];
    return UserEntity.fromJson(user);
  }

  static UserEntity? praseUsersFromJson(String json) {
    Map<String, dynamic> parsed = jsonDecode(json);
    if (parsed['data'].length == 0) {
      return null;
    }
    final user = parsed['data'][0];
    return UserEntity.fromJson(user);
  }
}
