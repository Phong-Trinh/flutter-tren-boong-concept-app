import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseCloudMessagingNotifications {

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  late FlutterLocalNotificationsPlugin fltLocalNotifyPlugin;

  var androidDetails = AndroidNotificationDetails('1', 'channelName');

  var iosDetails = DarwinNotificationDetails();


  void pushFCMToken() async {
    String? token = await firebaseMessaging.getToken();
    print("This is token:$token");
  }

  void initMessaging(BuildContext context) {

    var androidInit = const AndroidInitializationSettings('@mipmap/launcher_icon');

    var iosInit = const DarwinInitializationSettings();

    var initSetting =InitializationSettings(android: androidInit,iOS: iosInit);

    fltLocalNotifyPlugin = FlutterLocalNotificationsPlugin();
    // fltLocalNotifyPlugin.initialize(initSetting);
    fltLocalNotifyPlugin.initialize(initSetting);

    var generalNotificationDetails = NotificationDetails(android: androidDetails,iOS: iosDetails);

    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if(notification != null && android != null){
        fltLocalNotifyPlugin.show(notification.hashCode, notification.title,notification.body, generalNotificationDetails);
      }

    });
  }

  void showMessageNotification(String title, String body){
    var generalNotificationDetails = NotificationDetails(android: androidDetails,iOS: iosDetails);
    fltLocalNotifyPlugin.show(0,title, body,generalNotificationDetails);
  }



}