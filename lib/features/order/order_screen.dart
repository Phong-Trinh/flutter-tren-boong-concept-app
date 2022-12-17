import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/order/order_state.dart';
import '../../domain/bloc/order/order_bloc.dart';
import 'confirm_order.dart';
import 'order_detail.dart';

class OrderScreen extends StatefulWidget {
  final OrderBloc orderBloc;
  const OrderScreen({super.key, required this.orderBloc});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.orderBloc,
      child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) => Scaffold(
              resizeToAvoidBottomInset: false,
              bottomNavigationBar: ConfirmOrder(orderBloc: widget.orderBloc),
              body: OrderDetail(orderBloc: widget.orderBloc))),
    );
  }
}
