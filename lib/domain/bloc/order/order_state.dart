import 'package:equatable/equatable.dart';

import '../../entity/order_entity.dart';

abstract class OrderState {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitialState extends OrderState {}

class OrderLoadingState extends OrderState {}

class OrderLoadSuccessState extends OrderState {
  final OrderEntity order;

  OrderLoadSuccessState(this.order);
}

class OrderLoadFailState extends OrderState {}

class OrderUpdateSuccess extends OrderState {
  final OrderEntity order;

  OrderUpdateSuccess(this.order);
}

class OrderUpdateFail extends OrderState {}

class OrderEmptyState extends OrderState {}

class OrderReadyState extends OrderState {}

class OrderSuccessState extends OrderState {}

class OrderFailState extends OrderState {}
