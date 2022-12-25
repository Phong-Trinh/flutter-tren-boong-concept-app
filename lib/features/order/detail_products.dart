import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/bloc/order/order_bloc.dart';
import '../../domain/bloc/order/order_event.dart';
import '../../domain/entity/order_detail_entity.dart';
import '../../utility/formater.dart';
import '../../utility/save_data.dart';
import '../pop_up/menu.dart';
import '../widgets/pop_over.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListDetailProduct extends StatelessWidget {
  final OrderBloc orderBloc;

  ListDetailProduct({super.key, required this.orderBloc});

  late List<OrderDetailEntity> details;

  @override
  Widget build(BuildContext context) {
    details = orderBloc.order.orderDetails;
    return Container(
        padding: const EdgeInsets.only(left: 10, right: 10),
        color: Colors.white,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Text(AppLocalizations.of(context)!.selectedProduct,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      SaveData.scaffoldKey.currentState!.showBottomSheet(
                          (context) => const Popover(child: MenuPopup()));
                    },
                    child: Container(
                        height: 30,
                        width: 55,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 243, 227, 214),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Center(
                            child: Text(AppLocalizations.of(context)!.buyMore,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 212, 93, 3),
                                    fontWeight: FontWeight.w700)))))
              ],
            ),
            const SizedBox(height: 25),
            details.isEmpty
                ? Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: double.infinity,
                    child: Text(
                        AppLocalizations.of(context)!
                            .thereAreNoProductsInTheCart,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromARGB(255, 212, 93, 3),
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontStyle: FontStyle.italic)))
                : Container(),
            for (var item in details)
              details.indexOf(item) == details.length - 1
                  ? DetailInforProduct(
                      item: item, isLastItem: false, orderBloc: orderBloc)
                  : DetailInforProduct(
                      item: item, isLastItem: true, orderBloc: orderBloc)
          ],
        ));
  }
}

class DetailInforProduct extends StatefulWidget {
  final OrderBloc orderBloc;
  final OrderDetailEntity item;
  final bool isLastItem;
  const DetailInforProduct(
      {super.key,
      required this.item,
      required this.isLastItem,
      required this.orderBloc});

  @override
  State<DetailInforProduct> createState() => _DetailInforProductState();
}

class _DetailInforProductState extends State<DetailInforProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
        decoration: widget.isLastItem
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
                Text(generateProductName(widget.item),
                    style: const TextStyle(
                        fontWeight: FontWeight.w700, height: 2)),
                Text(AppLocalizations.of(context)!.mediumSize,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color.fromARGB(255, 106, 106, 106))),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: GestureDetector(
                          onTap: () {
                            // call decrease product funtion here
                            setState(() {
                              widget.orderBloc.add(
                                  DecreaseProductItem(widget.item.product));
                            });
                          },
                          child: Container(
                              height: 20,
                              width: 20,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 243, 227, 214),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              child: const Center(
                                  child: Icon(
                                      size: 20,
                                      color: Color.fromARGB(255, 212, 93, 3),
                                      Icons.remove)))),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
                      child: Text(generateProductQuanity(widget.item),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          )),
                    ),
                    widget.item.product.type == 'card'
                        ? SizedBox(width: 28)
                        : Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                                onTap: () {
                                  // call add product funtion here

                                  setState(() {
                                    widget.orderBloc.add(
                                        AddProductItem(widget.item.product));
                                  });
                                },
                                child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 243, 227, 214),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15))),
                                    child: const Center(
                                        child: Icon(
                                            size: 20,
                                            color:
                                                Color.fromARGB(255, 212, 93, 3),
                                            Icons.add)))),
                          ),
                  ],
                ),
                Text(generatePrice(widget.item),
                    style: const TextStyle(fontSize: 15)),
              ],
            ),
          ],
        ));
  }

  String generateProductName(OrderDetailEntity item) {
    return item.product.name;
  }

  String generateProductQuanity(OrderDetailEntity item) {
    return item.quantity.toString();
  }

  String generatePrice(OrderDetailEntity item) {
    return Formater.vndFormat(item.price * item.quantity);
  }
}
