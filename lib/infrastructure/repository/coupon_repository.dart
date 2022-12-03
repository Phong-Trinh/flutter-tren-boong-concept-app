import '../../domain/entity/coupon_entity.dart';
import '../remote_source/coupon_service.dart';

class CouponRepository {
  Future<List<CouponEntity>> fetchCouponsByUser(String id) async {
    return await CouponService.getUserPromotion(id);
  }
}
