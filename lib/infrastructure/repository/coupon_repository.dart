import '../../domain/entity/coupon_entity.dart';

class CouponRepository {
  List<CouponEntity> fetchCouponsByUser(String id) {
    return [
      CouponEntity(
          id: 1,
          title: 'Giảm đến 20k cho thức uống các loại',
          minimumPrice: 0,
          couponPrice: 20000,
          wasUsed: true),
      CouponEntity(
          id: 2,
          title: 'Giảm đến 45k khi mua từ 145k',
          minimumPrice: 145000,
          couponPrice: 45000,
          wasUsed: true),
      CouponEntity(
          id: 3,
          title: 'Giảm đến 10k cho thức uống các loại',
          minimumPrice: 0,
          couponPrice: 10000,
          wasUsed: true),
      CouponEntity(
          id: 4,
          title: 'Giảm đến 20k cho thức uống các loại',
          minimumPrice: 0,
          couponPrice: 20000,
          wasUsed: false)
    ];
  }
}
