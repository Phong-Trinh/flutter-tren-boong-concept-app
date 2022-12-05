import 'dart:convert';
import '../../domain/entity/coupon_entity.dart';
import 'api_constant.dart';
import 'package:http/http.dart' as http;

class CouponService {
  static Future<List<CouponEntity>> getUserPromotion(String id) async {
    try {
      var url = Uri.parse(
          '${ApiConstant.baseUrl}/user-coupons?filters[app_user][id][\$eq]=${id}&populate=*');
      var response = await http.get(url);
      print(url);
      if (response.statusCode == 200) {
        print(response.body);
        List<CouponEntity> coupons = praseCouponFromJson(response.body);
        return coupons;
      }
    } catch (e) {
      print(e.toString());
    }
    return [];
  }

  static List<CouponEntity> praseCouponFromJson(String json) {
    Map<String, dynamic> parsed = jsonDecode(json);
    final couponsJson = parsed['data'];
    List<CouponEntity> coupons = [];
    couponsJson.forEach((coupon) => coupons.add(CouponEntity.fromJson(coupon)));
    return coupons;
  }
}
