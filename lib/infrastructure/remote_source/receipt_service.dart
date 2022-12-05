import 'dart:convert';
import '../../domain/entity/order_entity.dart';
import 'api_constant.dart';
import 'package:http/http.dart' as http;

class ReceiptService {
  static Future<int?> createReceipt(
      int total, List<int> listDetailId, int userId) async {
    try {
      var response = await sendPostReceipt(total, listDetailId, userId);
      if (response.statusCode == 200) {
        Map<String, dynamic> parsed = jsonDecode(response.body);
        int id = parsed['data']['id'];
        print(id.toString());
        return id;
      }
    } catch (e) {
      //print(e.toString());
    }
    return null;
  }

  // static OrderEntity praseUserFromJson(String json) {
  //   Map<String, dynamic> parsed = jsonDecode(json);
  //   final user = parsed['data'][0];
  //   return OrderEntity.fromJson(user);
  // }

  static Future<http.Response> sendPostReceipt(
      int total, List<int> listDetailId, int userId) {
    return http.post(
      Uri.parse('${ApiConstant.baseUrl}/receipts'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, Object>{
        "data": {
          "subTotal": total,
          "total": total,
          "receipt_details": listDetailId,
          "app_user": userId
        }
      }),
    );
  }
}
