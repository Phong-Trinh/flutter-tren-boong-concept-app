import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/bloc/order/order_bloc.dart';
import '../../domain/bloc/order/order_state.dart';
import '../../domain/entity/order_entity.dart';
import '../../utility/formater.dart';
import 'order_detail_price.dart';
import 'order_list.dart';
import 'order_coupon.dart';
import 'order_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShortOrderBar extends StatefulWidget {
  const ShortOrderBar({super.key});

  @override
  State<ShortOrderBar> createState() => ShortOrderBarState();
}

class ShortOrderBarState extends State<ShortOrderBar> {
  @override
  Widget build(BuildContext context) {
    OrderEntity order = context.read<OrderBloc>().order;
    return BlocProvider.value(
        value: context.read<OrderBloc>(),
        child: BlocBuilder<OrderBloc, OrderState>(
            builder: (BuildContext context, OrderState state) {
          if (state is OrderUpdateSuccess) {
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context1) =>
                          OrderScreen(orderBloc: context.read<OrderBloc>())));
                },
                child: Container(
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255)),
                    height: 70,
                    child: Row(children: [
                      const SizedBox(width: 15),
                      Flexible(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            OrderCoupon(
                                coupon: context.read<OrderBloc>().order.coupon),
                            const SizedBox(height: 5),
                            OrderList(
                                orderList: order.orderDetails.isEmpty
                                    ? AppLocalizations.of(context)!
                                        .thereAreNoProductsYet
                                    : Formater.getStringListOrderName(
                                        context.read<OrderBloc>().order))
                          ])),
                      const SizedBox(width: 12),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context1) => OrderScreen(
                                    orderBloc: context.read<OrderBloc>())));
                          },
                          child: OrderDetailPrice(
                              itemCount: Formater.getTotalItem(order),
                              totalPrice: Formater.getTotalPrice(order))),
                      const SizedBox(width: 15)
                    ])));
          }
          return Container();
        }));
  }
}
