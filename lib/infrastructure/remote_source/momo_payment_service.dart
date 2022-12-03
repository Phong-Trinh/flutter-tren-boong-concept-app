import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MomoPaymentService {
  static String accessKey = "66Nd3LHzNwUnA2As";
  static String partnerCode = "MOMOKPCW20221129";
  static String requestType = "captureWallet";
  static String notifyUrl =
      "https://boiling-waters-91078.herokuapp.com/api/momo-payments";
  static String returnUrl =
      "https://master--cheerful-crumble-ea2dee.netlify.app/";
  static String extraData = "ew0KImVtYWlsIjogImh1b25neGRAZ21haWwuY29tIg0KfQ==";
  static String orderInfo = "Thanh toán qua ví MoMo";
  static Future<bool> createTransaction(String orderId, int totalPrice) async {
    DateTime now;
    try {
      now = DateTime.now();
      //test
      orderId = now.millisecondsSinceEpoch.toString();
      String requestId = now.millisecondsSinceEpoch.toString() + orderId;
      String signature =
          generateSignature(orderId.toString(), totalPrice, requestId);
      var response = await http.post(
        Uri.parse('https://test-payment.momo.vn/v2/gateway/api/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "partnerCode": partnerCode,
          "partnerName": "Test",
          "storeId": partnerCode,
          "requestType": requestType,
          "ipnUrl": notifyUrl,
          "redirectUrl": returnUrl,
          "orderId": orderId,
          "amount": totalPrice.toString(),
          "lang": "vi",
          "autoCapture": true,
          "orderInfo": orderInfo,
          "requestId": requestId,
          "extraData": extraData,
          "signature": signature
        }),
      );
      print(signature);
      if (response.statusCode == 200) {
        Map<String, dynamic> parsed = jsonDecode(response.body);
        await launchUrl(Uri.parse(parsed['payUrl']),
            mode: LaunchMode.externalApplication);
        return true;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
    return false;
  }

  static String generateSignature(
      String orderId, int totalPrice, String requestId) {
    String fromString =
        'accessKey=${accessKey}&amount=${totalPrice.toString()}&extraData=${extraData}&ipnUrl=${notifyUrl}&orderId=${orderId}&orderInfo=${orderInfo}&partnerCode=${partnerCode}&redirectUrl=${returnUrl}&requestId=${requestId}&requestType=${requestType}';
    String secretKey = "q7iRuRvxEddxrzIdBvdqg2lNRgCaN9fa";
    List<int> secretBytes = utf8.encode(secretKey);
    List<int> messageBytes = utf8.encode(fromString);
    var hmacSha256 = Hmac(sha256, secretBytes);
    Digest digest = hmacSha256.convert(messageBytes);
    return "$digest";
  }
}
