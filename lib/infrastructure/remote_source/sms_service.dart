import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';

class SmsService {
  static String EndPoint = 'https://api.abenla.com/api';
  static Future<bool> SendOtpSms(
      {required String phoneNumb, required String otpCode}) async {
    String message =
        "Here is your otp code: ${otpCode}. Please keep it privat and don't share with anybody";
    var url = Uri.parse(
        '${EndPoint}/SendOTP?loginName=AB9P2D9&sign=${generateMd5('PNDG4KNYL')}&serviceTypeId=30&phoneNumber=${phoneNumb}&message=${message}&brandName=ABENLA&callBack=false');
    print(url.toString());
    try {
      var response = await http.get(url);
      Map<String, dynamic> body = jsonDecode(response.body);
      if (body['Code'] == 203) {
        return true;
      }
      return true;
    } catch (e) {
      print(e.toString());
    }
    return false;
  }

  static String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
