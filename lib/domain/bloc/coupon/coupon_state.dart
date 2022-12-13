import 'package:equatable/equatable.dart';
import '../../entity/coupon_entity.dart';

abstract class CouponState extends Equatable {
  const CouponState();

  @override
  List<Object> get props => [];
}

class CouponInitialState extends CouponState {}

class CouponLoadingState extends CouponState {}

class CouponUpdateSuccess extends CouponState {
  final List<CouponEntity> coupons;
  const CouponUpdateSuccess(this.coupons);
}

class CouponLoadFailed extends CouponState {}
