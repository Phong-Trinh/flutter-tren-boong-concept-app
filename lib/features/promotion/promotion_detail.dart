import 'package:flutter/material.dart';

import '../../domain/entity/coupon_entity.dart';
import '../../utility/formater.dart';
import 'promotion_date.dart';
import 'promotion_infor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; 

class PromotionDetail extends StatelessWidget {
  const PromotionDetail(
      {super.key, required this.coupon, required this.isSelected});
  final CouponEntity coupon;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    Color borderColor = isSelected
        ? Color.fromARGB(255, 16, 131, 52)
        : Color.fromARGB(255, 146, 144, 144);

    Color textColor =
        isSelected ? Color.fromARGB(218, 12, 124, 47) : Colors.black;
    return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1.0),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(children: [
          PromotionInfor(
              title: coupon.title,
              details: [
                AppLocalizations.of(context)!.discount +
                    '${Formater.vndFormat(coupon.couponPrice)}' +
                    AppLocalizations.of(context)!.forAnyDrink,
                AppLocalizations.of(context)!.miniumOrder +
                    '${Formater.vndFormat(coupon.minimumPrice)}'
              ],
              textColor: textColor),
          Divider(height: 10, color: borderColor, thickness: 0.4),
          PromotionDate(
              textColor: textColor,
              date: isSelected
                  ? AppLocalizations.of(context)!.selected
                  : AppLocalizations.of(context)!.promotionIsLimited,
              icon: isSelected
                  ? Icons.check_circle_rounded
                  : Icons.access_time_filled_rounded)
        ]));
  }
}
