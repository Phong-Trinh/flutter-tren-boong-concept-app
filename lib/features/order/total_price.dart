import 'package:flutter/material.dart';

import '../../domain/entity/order_entity.dart';
import '../../utility/formater.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TotalPrice extends StatelessWidget {
  final OrderEntity order;
  const TotalPrice({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(AppLocalizations.of(context)!.totalprice,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            const SizedBox(height: 25),
            DetailPrice(
                title: AppLocalizations.of(context)!.totalAmount,
                price: generatePrice(order)),
            DetailPrice(
                title: AppLocalizations.of(context)!.discount,
                price: order.coupon != null
                    ? '-${Formater.vndFormat(order.coupon!.couponPrice)}'
                    : '-${Formater.vndFormat(0)}'),
            PayPrice(
                title: AppLocalizations.of(context)!.amountToPay,
                price: Formater.vndFormat(order.totalPrice))
          ],
        ));
  }

  String generatePrice(OrderEntity order) {
    return Formater.vndFormat(order.coupon != null
        ? order.totalPrice + order.coupon!.couponPrice
        : order.totalPrice);
  }
}

class DetailPrice extends StatelessWidget {
  final String title;
  final String price;
  const DetailPrice({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        decoration: const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color.fromARGB(255, 185, 185, 185)))),
        child: Row(
          children: [
            Text(title, style: const TextStyle(height: 2)),
            const Spacer(),
            Text(price, style: const TextStyle(fontSize: 16))
          ],
        ));
  }
}

class PayPrice extends StatelessWidget {
  final String title;
  final String price;
  const PayPrice({super.key, required this.title, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Row(
          children: [
            Text(title,
                style: const TextStyle(fontWeight: FontWeight.w700, height: 2)),
            const Spacer(),
            Text(price, style: const TextStyle(fontSize: 16))
          ],
        ));
  }
}
