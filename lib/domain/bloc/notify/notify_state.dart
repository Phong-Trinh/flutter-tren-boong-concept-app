import 'package:equatable/equatable.dart';
import 'package:tren_boong_concept/domain/entity/notify_entity.dart';

class NotifyState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props =>[];

}
class NotifyInialState extends NotifyState{

}
class NotifyMessageState extends NotifyState{
  final NotifyEntity notifyEntity;

  NotifyMessageState(this.notifyEntity);
}