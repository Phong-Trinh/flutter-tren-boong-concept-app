import 'package:flutter/material.dart';

import '../../domain/entity/coupon_entity.dart';
import '../../utility/formater.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderCoupon extends StatelessWidget {
  final CouponEntity? coupon;
  const OrderCoupon({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        margin: const EdgeInsets.only(right: 2),
        height: 28,
        width: 28,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/icon/coupon-icon.png"),
          fit: BoxFit.cover,
        )),
      ),
      DefaultTextStyle(
          style: TextStyle(
              color: Color.fromARGB(255, 57, 56, 56),
              fontWeight: FontWeight.w500,
              fontSize: 12),
          child: Text((coupon == null)
              ? AppLocalizations.of(context)!.noDiscountCodeYet
              : AppLocalizations.of(context)!.discountedBill +
                  '${Formater.vndFormat(coupon!.couponPrice)}'))
    ]);
  }
}
