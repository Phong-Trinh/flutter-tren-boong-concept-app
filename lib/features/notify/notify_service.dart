import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:tren_boong_concept/domain/entity/notify_entity.dart';

class NotifyService  {

  NotifyService._internal();

  static final NotifyService _notifyService = NotifyService._internal();
  factory NotifyService(){
    return _notifyService;
  }

  static const AndroidNotificationDetails _androidNotificationDetails =
  AndroidNotificationDetails(
    'ChannelId',
    'ChannelName',
    channelDescription: "Responsible for all local notifications",
    playSound: true,
    priority: Priority.high,
    importance: Importance.max,
  );

  static const DarwinNotificationDetails _darwinNotificationDetails =
  DarwinNotificationDetails();

  final NotificationDetails notificationDetails =
  const NotificationDetails(android: _androidNotificationDetails,iOS: _darwinNotificationDetails);

  static final _notifications = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings initializationSettingsDarwin =
    const DarwinInitializationSettings();
    InitializationSettings initializationSettings =
    InitializationSettings(android: androidInitializationSettings,iOS: initializationSettingsDarwin);
    await _notifications.initialize(initializationSettings);
  }

  Future<void> showNotification(NotifyEntity notifyEntity) async {
    await _notifications.show(notifyEntity.id, notifyEntity.title, notifyEntity.body, notificationDetails,payload: notifyEntity.payload);
  }

}