import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class GetListNews extends NewsEvent {
  
  
}

class ApplyCouponToOrder extends NewsEvent {}
