import 'package:flutter/material.dart';
import '../../domain/entity/order_detail_entity.dart';
import '../../utility/formater.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DetailAPaymentMethod extends StatelessWidget {
  const DetailAPaymentMethod({super.key});

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
                Text(AppLocalizations.of(context)!.paymentMethod,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: 25),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                  child: Row(children: [
                Image(
                    height: 32,
                    width: 32,
                    image: AssetImage('assets/icon/momo-icon.png')),
                SizedBox(width: 8),
                Text(AppLocalizations.of(context)!.payWithMomoWallet,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16, height: 2))
              ])),
              const Spacer(),
              Checkbox(
                  onChanged: (d) {},
                  checkColor: Color.fromARGB(255, 212, 93, 3),
                  activeColor: Color.fromARGB(255, 228, 226, 226),
                  value: true)
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
                const Text('Vừa',
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
