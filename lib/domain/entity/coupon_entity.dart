class CouponEntity {
  final int id;
  final String title;
  final int minimumPrice;
  final int couponPrice;
  final bool wasUsed;

  CouponEntity(
      {required this.id,
      required this.title,
      required this.minimumPrice,
      required this.couponPrice,
      required this.wasUsed});
}
