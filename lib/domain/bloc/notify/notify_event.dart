import 'package:equatable/equatable.dart';
import 'package:tren_boong_concept/domain/entity/notify_entity.dart';

class NotifyEvent extends Equatable {
  const NotifyEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ReceivedNotificationEvent extends NotifyEvent {
  final NotifyEntity notifyEntity;
  const ReceivedNotificationEvent(this.notifyEntity) : super();
}