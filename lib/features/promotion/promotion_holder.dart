import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/coupon/coupon_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/coupon/coupon_state.dart';
import '../../domain/bloc/coupon/coupon_event.dart';
import '../../infrastructure/repository/coupon_repository.dart';
import '../../utility/save_data.dart';
import 'promotion_list.dart';
import 'shimmer_promotion.dart';

class PromotionHolder extends StatefulWidget {
  const PromotionHolder({super.key});

  @override
  State<PromotionHolder> createState() => PromotionHolderState();
}

class PromotionHolderState extends State<PromotionHolder> {
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
        create: (context) => CouponRepository(),
        child: BlocProvider(
            create: (context) => CouponBloc(
                couponRepository: context.read<CouponRepository>(),
                selectedCouponId: SaveData.selectedCouponId)
              ..add(GetUserCoupon(SaveData.userId)),
            child: BlocBuilder<CouponBloc, CouponState>(
                builder: (BuildContext context, CouponState state) {
              if (state is CouponUpdateSuccess) {
                return PromotionList(coupons: state.coupons);
              }
              return ShimmerPromotion();
            })));
  }
}
