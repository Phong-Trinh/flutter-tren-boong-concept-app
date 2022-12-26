import 'package:flutter/material.dart';
import '../../domain/entity/coupon_entity.dart';
import '../../domain/entity/order_detail_entity.dart';
import '../../utility/formater.dart';
import '../../utility/save_data.dart';
import '../promotion/promotion.dart';
import '../widgets/pop_over.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailAppliedCoupon extends StatelessWidget {
  final CouponEntity? coupon;
  const DetailAppliedCoupon({super.key, required this.coupon});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.coupon,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      SaveData.scaffoldKey.currentState!.showBottomSheet(
                          (context) => const Popover(child: PromotionPopup()));
                    },
                    child: Container(
                        height: 30,
                        width: 60,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 243, 227, 214),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Center(
                            child: Text(AppLocalizations.of(context)!.change,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 212, 93, 3),
                                    fontWeight: FontWeight.w700)))))
              ],
            ),
            const SizedBox(height: 25),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Flexible(
                  child: Container(
                      child: Text(
                          coupon != null
                              ? coupon!.title
                              : AppLocalizations.of(context)!.doNotApply,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, height: 2)))),
              const Spacer(),
              Text(
                  '-${Formater.vndFormat(coupon != null ? coupon!.couponPrice : 0)}',
                  style: const TextStyle(fontSize: 16))
            ]),
            const SizedBox(height: 10)
          ],
        ));
  }
}

class DetailInforProduct extends StatelessWidget {
  final OrderDetailEntity item;
  final bool isLastItem;
  const DetailInforProduct(
      {super.key, required this.item, required this.isLastItem});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
        decoration: isLastItem
            ? const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1, color: Color.fromARGB(255, 185, 185, 185))))
            : null,
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(generateProductName(item),
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, height: 2)),
                Text(AppLocalizations.of(context)!.mediumSize,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color.fromARGB(255, 106, 106, 106)))
              ],
            ),
            const Spacer(),
            Text(generatePrice(item), style: const TextStyle(fontSize: 16))
          ],
        ));
  }

  String generateProductName(OrderDetailEntity item) {
    return item.quantity.toString() + 'x ' + item.product.name;
  }

  String generatePrice(OrderDetailEntity item) {
    return Formater.vndFormat(item.price * item.quantity);
  }
}
