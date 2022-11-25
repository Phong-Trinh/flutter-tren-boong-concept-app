import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tren_boong_concept/domain/bloc/notify/notify_event.dart';
import 'package:tren_boong_concept/domain/bloc/notify/notify_state.dart';
import 'package:tren_boong_concept/domain/entity/notify_entity.dart';
import 'package:tren_boong_concept/features/notify/notify_service.dart';

class NotifyBloc extends Bloc<NotifyEvent,NotifyState>{

  final NotifyService _notifyService = NotifyService();

  NotifyBloc() : super(NotifyInialState()) {
    on<ReceivedNotificationEvent>(_buildShowMessageNotify);
  }

  Future<void> _buildShowMessageNotify(ReceivedNotificationEvent event, Emitter<NotifyState> emit) async {
    // Dùng get http request để kiểm tra món ăn đã được thanh toán thành công hay không
      try{
        _notifyService.showNotification(NotifyEntity(id:0, title: event.notifyEntity.title,body: event.notifyEntity.body));
      }
      catch(error){
        _notifyService.showNotification(NotifyEntity(id:0, title: "Lỗi xảy ra",body: "Đơn món của bạn không được đặt thành công "));
      }
  }
}