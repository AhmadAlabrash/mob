import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../customizations.dart';
import '../main.dart';
import '../services/push_notification_service.dart';
import '../views/conversation_view/conversation_view.dart';
import '../views/my_order_details_view/my_order_details_view.dart';
import '../views/offer_details_view/offer_details_view.dart';
import 'constant_helper.dart';
import 'firebase_messaging_helper.dart';
import 'pusher_helper.dart';

class NotificationHelper {
  StreamSubscription<String?>? streamSubscription;

  notificationAppLaunchChecker(BuildContext context) async {
    print(
        '${notificationDetails?.notificationResponse?.payload}App launch notification details');
    if (notificationDetails?.notificationResponse?.payload != null) {
      final payload = jsonDecode(
          notificationDetails?.notificationResponse?.payload ?? "{}");
      await Future.delayed(const Duration(milliseconds: 10));
      proceedRouting(payload);
      if (payload["type"].toString().contains("order")) {
        print('from app launch');
        // navigatorKey.currentState
        //     ?.pushNamed(OrderDetailsView.routeName,
        //         arguments: payload["id"].toString())
        //     .then((value) => selectedNotificationPayload = null);
      }
      setNotificationDetails(null);
    }
  }

  streamListener(BuildContext context) {
    streamSubscription ??= selectNotificationStream.stream.listen(
      (event) async {
        // if (notificationCount.value > 1) {
        //   notificationCount.value = 0;
        // }
        bool notNavigated = true;
        if (notNavigated) {
          debugPrint(
              '$selectedNotificationPayload App launch notification details');
          final payLoad = jsonDecode(selectedNotificationPayload ?? "{}");
          debugPrint("Notification type is ${payLoad["type"]}".toString());
          proceedRouting(payLoad);
          notNavigated = false;
        }
      },
    );
  }

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  initiateNotification(BuildContext context) async {
    final pnProvider = PushNotificationService();
    if (pnProvider.userToken != null) {
      print('User fire token: ${pnProvider.userToken}');
      return;
    }
    NotificationSettings settings = await messaging.requestPermission(
        alert: false,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: false);
    pnProvider.setUserToken(await messaging.getToken());
    print('User granted permission: ${settings.authorizationStatus}');
    print('User fire token: ${pnProvider.userToken}');

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final msgId = message.data['id'] is String
          ? int.tryParse(message.data['id'])
          : message.data['id'];

      String title = message.data['title'] ?? "";
      String description = message.data['body'] ?? "";
      String identity = message.data['identity'] ?? "";
      if (message.data['type'] == "Order") {
        title = description;
        description = "${LocalKeys.orderId}: #$identity";
      }
      if (message.data['type'] == "message") {
        var liveChatData = jsonDecode(message.data["livechat"] ?? "{}");
        // log(message.data.toString());
        try {
          log((liveChatData["freelancer"]).toString());
          title = liveChatData["freelancer"]?["first_name"]?.toString() ?? "";
          debugPrint("title added".toString());
          description = jsonDecode(message.data['body'] ?? "{}")?["message"]
                  ?.toString() ??
              "";
          debugPrint("message added".toString());
        } catch (e) {
          log((liveChatData is Map).toString());
          log(e.toString());
        }
      }
      log(message.data.toString());
      // notificationCount.value += 1;
      debugPrint("notification data is".toString());
      debugPrint(message.data.toString());
      selectedNotificationPayload = jsonEncode(message.data);
      NotificationHelper().triggerNotification(
          id: msgId ?? 1,
          body: description ?? message.data['body'],
          title: title ?? message.data["title"],
          payload: message.data);

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    final deviceToken = await messaging.getToken();
    debugPrint((deviceToken).toString());
    messaging.subscribeToTopic('all');
  }

  triggerNotification(
      {required int id,
      required String title,
      required String body,
      payload,
      String? channelName}) {
    // flutterLocalNotificationsPlugin.cancelAll();
    debugPrint(payload.toString());
    flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            '$id',
            channelName ?? 'channelName',
            priority: Priority.max,
            importance: Importance.max,
            visibility: NotificationVisibility.public,
          ),
        ),
        payload: jsonEncode(payload));
  }
}

proceedRouting(Map payLoad) {
  String type = payLoad['type'] ?? "name";
  if (type == "Order") {
    String identity = payLoad['identity'] ?? "";
    if (orderId != null) {
      navigatorKey.currentState?.pop();
    }
    navigatorKey.currentState?.pushNamed(MyOrderDetailsView.routeName,
        arguments: identity.toString());
  }
  if (type == "Offer") {
    String offerId = payLoad['identity'] ?? "";
    if (orderId != null) {
      navigatorKey.currentState?.pop();
    }
    navigatorKey.currentState?.push(MaterialPageRoute(
      builder: (context) => OfferDetailsView(id: offerId),
    ));
  }
  if (type == "message") {
    var liveChatData = jsonDecode(payLoad["livechat"] ?? "{}");
    // log(message.data.toString());
    try {
      if (conversationId.toString() == liveChatData["id"].toString()) {
        return;
      }
      if (conversationId != null) {
        navigatorKey.currentState?.pop();
      }
      var clientId = liveChatData["client"]?["id"]?.toString() ?? "";
      var freelancer = liveChatData["freelancer"] ?? {};

      navigatorKey.currentState
          ?.pushNamed(ConversationView.routeName, arguments: [
        liveChatData["id"].toString(),
        freelancer["first_name"] + " " + freelancer["last_name"],
        "$userProfilePath/${liveChatData["freelancer"]?["image"]?.toString() ?? ""}",
        freelancer?["id"],
        liveChatData["freelancer_id"]
      ]).then((value) {
        selectedNotificationPayload = null;

        PusherHelper().disConnect();
        setConversationId(null);
      });

      debugPrint("message added".toString());
    } catch (e) {
      log((liveChatData is Map).toString());
      log(e.toString());
    }
  }
}

var safsd = {
  "google_id": null,
  "google_2fa_secret": "HATKCPGN5WGPJEFU",
  "email_verify_token": "876626",
  "user_active_inactive_status": 1,
  "is_email_verified": "1",
  "about": null,
  "created_at": "2023-01-23T02:03:28.000000Z",
  "check_work_availability": 1,
  "user_type": 1,
  "updated_at": "2024-03-10T11:53:54.000000Z",
  "id": 1,
  "state_id": 1,
  "first_name": "Test",
  "email": "tclient@gmail.com",
  "image": "1680500462-642a66ee548e7.jpg",
  "last_name": "Client",
  "email_verified_at": null,
  "terms_condition": 1,
  "firebase_device_token": null,
  "deleted_at": null,
  "is_suspend": 0,
  "facebook_id": null,
  "check_online_status": "2024-03-10T11:53:54.000000Z",
  "google_2fa_enable_disable_disable": 0,
  "phone": "0189232",
  "user_verified_status": 1,
  "hourly_rate": 0,
  "github_id": null,
  "experience_level": "junior",
  "country_id": 1,
  "username": "client",
  "city_id": 1
};
