class CouponEntity {
  final int id;
  final String title;
  final int minimumPrice;
  final int couponPrice;
  final bool enable;

  CouponEntity(
      {required this.id,
      required this.title,
      required this.minimumPrice,
      required this.couponPrice,
      required this.enable});
  factory CouponEntity.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final coupon = attributes['coupon'];
    var k = coupon['data']['attributes']['tittle'];
    print(coupon['data']['attributes']['tittle']);
    return CouponEntity(
        id: json['id'],
        title: coupon['data']['attributes']['tittle'],
        minimumPrice: int.parse(coupon['data']['attributes']['minimumPrice']),
        couponPrice: int.parse(coupon['data']['attributes']['downPrice']),
        enable: attributes['available']);
  }
}
