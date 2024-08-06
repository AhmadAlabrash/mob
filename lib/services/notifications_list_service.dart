import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/message_notification_count_service.dart';
import '../../helper/constant_helper.dart';
import '../../helper/extension/string_extension.dart';
import '../../helper/local_keys.g.dart';
import '../../models/notification_list_model.dart';

import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';

class NotificationsListService with ChangeNotifier {
  NotificationListModel? _notificationsList;
  NotificationListModel get notificationsList =>
      _notificationsList ?? NotificationListModel();
  var token = "";
  bool loading = false;

  var nextPage;

  bool nextPageLoading = false;
  bool nexLoadingFailed = false;

  bool get shouldAutoFetch => _notificationsList == null || token.isInvalid;

  fetchNotificationsList() async {
    token = getToken;
    final responseData = await NetworkApiServices().getApi(
        AppUrls.notificationsListUrl, LocalKeys.notifications,
        headers: commonAuthHeader);

    if (responseData != null) {
      _notificationsList =
          NotificationListModel.fromJson(responseData["notifications"] ?? {});
      nextPage = notificationsList.nexPageUrl;
      debugPrint((_notificationsList?.notifications?.length).toString());
    } else {
      // notificationsList ??= [];
    }
    notifyListeners();
  }

  fetchNextPage() async {
    token = getToken;
    debugPrint("next page loading for notification list".toString());
    if (nextPageLoading) return;
    nextPageLoading = true;
    final responseData = await NetworkApiServices()
        .getApi(nextPage, LocalKeys.notifications, headers: commonAuthHeader);

    if (responseData != null) {
      final tempData =
          NotificationListModel.fromJson(responseData["notifications"] ?? {});
      tempData.notifications?.forEach((element) {
        _notificationsList?.notifications?.add(element);
      });
      nextPage = tempData.nexPageUrl;
    } else {
      nexLoadingFailed = true;
      Future.delayed(const Duration(seconds: 1)).then((value) {
        nexLoadingFailed = false;
        notifyListeners();
      });
    }
    nextPageLoading = false;
    notifyListeners();
  }

  updateNotification(BuildContext context) async {
    // if (AppUrls.deleteAccountUrl.toLowerCase().contains("xgenious")) {
    //   Provider.of<MessageNotificationCountService>(context, listen: false)
    //       .setNC(0);
    //   return;
    // }
    final responseData = await NetworkApiServices().postApi(
        {}, AppUrls.updateNotificationUrl, LocalKeys.notifications,
        headers: commonAuthHeader);
    if (responseData != null) {
      Provider.of<MessageNotificationCountService>(context, listen: false)
          .setNC(0);
    }
  }
}
