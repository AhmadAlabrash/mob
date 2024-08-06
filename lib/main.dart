import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:xilancer/app.dart';

import 'helper/firebase_messaging_helper.dart';
import 'helper/notification_helper.dart';
import 'helper/firebase_messaging_helper.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  await setupFlutterNotifications();
  final messageData = message.data;
  final id = messageData['id'] is String
      ? int.tryParse(messageData['id'])
      : messageData['id'];
  debugPrint(id.toString());
  NotificationHelper().triggerNotification( 
      id: id,
      body: messageData['body'],
      title: messageData['title'],
      payload: message.data);
}

final navigatorKey = GlobalKey<NavigatorState>(debugLabel: "nav_key");
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    onDidReceiveLocalNotification: (id, title, body, payload) {},
  );

  flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(
      android: const AndroidInitializationSettings('notification_icon'),
      iOS: initializationSettingsDarwin,
    ),
    onDidReceiveBackgroundNotificationResponse: staticFuctionOnForground,
    onDidReceiveNotificationResponse: staticFuctionOnForground,
  );
  final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

  // final bool? granted = await androidImplementation?.requestPermission();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }

  setNotificationDetails(
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails());
  debugPrint((notificationDetails?.notificationResponse?.payload).toString());

  runApp(const XilancerApp());
}
