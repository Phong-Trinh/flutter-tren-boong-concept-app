import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/bloc/order/order_bloc.dart';
import '../../domain/bloc/order/order_event.dart';
import '../../domain/entity/coupon_entity.dart';
import '../../utility/save_data.dart';
import 'promotion_detail.dart';

class PromotionList extends StatefulWidget {
  const PromotionList({super.key, required this.coupons});
  final List<CouponEntity> coupons;

  @override
  State<PromotionList> createState() => _PromotionListState();
}

class _PromotionListState extends State<PromotionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (var coupon in widget.coupons)
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (coupon.id == SaveData.selectedCouponId) {
                      SaveData.selectedCouponId = -1;
                    } else {
                      SaveData.selectedCouponId = coupon.id;
                    }
                  });
                  print(SaveData.selectedCouponId.toString());
                  context.read<OrderBloc>().add(AddCoupon(coupon));
                },
                child: PromotionDetail(
                    coupon: coupon,
                    isSelected: (coupon.id == SaveData.selectedCouponId)))
        ]));
  }
}
