import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:teer_common/services/push_notification_service.dart';

void fireBaseMessagingService(context) {
  FirebaseMessaging.instance.getInitialMessage().then((message) {
    if (message != null) {
      final routeFromMessage = message.data["navigate"];
      Navigator.of(context).pushNamed("/" + routeFromMessage);
    }
  });

  //Foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification != null) {
      //Do somthing if you want to do
    }
    LocalNotificationService.display(message);
  });
//when the app is in the background and opened the user tap on the notification
//
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    final routeFromMessage = message.data["navigate"];
    Navigator.of(context).pushNamed("/" + routeFromMessage);
  });
}
