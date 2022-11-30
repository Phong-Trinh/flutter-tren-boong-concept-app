import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/bloc/order/order_bloc.dart';
import '../../domain/bloc/order/order_event.dart';
import '../../domain/entity/coupon_entity.dart';
import 'promotion_detail.dart';

class PromotionList extends StatefulWidget {
  const PromotionList({super.key, required this.coupons});
  final List<CouponEntity> coupons;

  @override
  State<PromotionList> createState() => _PromotionListState();
}

class _PromotionListState extends State<PromotionList> {
  int selectedCoupon = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (var coupon in widget.coupons)
            GestureDetector(
                onTap: () {
                  setState(() {
                    selectedCoupon = widget.coupons.indexOf(coupon);
                  });
                  print(selectedCoupon);
                  context.read<OrderBloc>().add(AddCoupon(coupon));
                },
                child: PromotionDetail(
                    coupon: coupon,
                    isSelected:
                        (widget.coupons.indexOf(coupon) == selectedCoupon)))
        ]));
  }
}
