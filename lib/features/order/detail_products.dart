import 'package:flutter/material.dart';
import '../../domain/entity/order_detail_entity.dart';
import '../../utility/formater.dart';

class ListDetailProduct extends StatelessWidget {
  final List<OrderDetailEntity> details;
  const ListDetailProduct({super.key, required this.details});

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
                const Text('Sản phẩm đã chọn',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                const Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        height: 30,
                        width: 55,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 243, 227, 214),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: const Center(
                            child: Text('Thêm',
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
                    child: const Text('*Không có sản phẩm trong giỏ hàng',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color.fromARGB(255, 212, 93, 3),
                            fontWeight: FontWeight.w500,
                            height: 2,
                            fontStyle: FontStyle.italic)))
                : Container(),
            for (var item in details)
              details.indexOf(item) == details.length - 1
                  ? DetailInforProduct(item: item, isLastItem: false)
                  : DetailInforProduct(item: item, isLastItem: true)
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
            GestureDetector(
                onTap: () {
                  // decrease product logic
                  //  context.read<OrderBloc>().add(DecreaseProductItem(item));
                },
                child: Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 243, 227, 214),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: const Center(
                        child: Icon(
                            color: Color.fromARGB(255, 212, 93, 3),
                            Icons.remove)))),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
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
