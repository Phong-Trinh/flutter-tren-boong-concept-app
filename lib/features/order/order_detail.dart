import 'package:flutter/material.dart';

import '../../domain/bloc/order/order_bloc.dart';
import 'confirm_order.dart';
import 'detail_applied_coupon.dart';
import 'detail_products.dart';
import 'total_price.dart';

class OrderDetail extends StatelessWidget {
  final OrderBloc orderBloc;
  const OrderDetail({super.key, required this.orderBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 210, 209, 209),
      height: MediaQuery.of(context).size.height - 30,
      child: ListView(children: [
        Container(
            height: 80,
            width: double.infinity,
            color: Colors.white,
            child: Center(
                child: Text('Xác nhận đơn hàng',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w700)))),
        SizedBox(height: 25),
        ListDetailProduct(details: orderBloc.order.orderDetails),
        SizedBox(height: 25),
        DetailAppliedCoupon(coupon: orderBloc.order.coupon),
        SizedBox(height: 25),
        TotalPrice(order: orderBloc.order),
      ]),
    );
  }
}
