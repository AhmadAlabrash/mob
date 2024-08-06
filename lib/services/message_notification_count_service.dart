import 'package:flutter/material.dart';
import 'package:xilancer/helper/constant_helper.dart';

import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';

class MessageNotificationCountService with ChangeNotifier {
  num messageCount = 0;
  num notificationCount = 0;

  setMC(value) {
    if (value == messageCount) {
      return;
    }
    debugPrint("setting MC $value".toString());
    messageCount = value;
    notifyListeners();
  }

  setNC(value) {
    if (value == notificationCount) {
      return;
    }
    notificationCount = value;
    notifyListeners();
  }

  fetchM() async {
    var url = AppUrls.mCountUrl;

    final responseData = await NetworkApiServices()
        .getApi(url, null, headers: acceptJsonAuthHeader);

    if (responseData != null) {
      messageCount = num.tryParse((responseData["unseen_message"]
                  ?["client_unseen_message_count"])
              .toString()) ??
          0;
      notifyListeners();
      return true;
    }
  }

  fetchN() async {
    var url = AppUrls.nCountUrl;

    final responseData = await NetworkApiServices()
        .getApi(url, null, headers: acceptJsonAuthHeader);

    if (responseData != null) {
      notificationCount =
          num.tryParse(responseData["unread_notifications"].toString()) ?? 0;
      notifyListeners();
      return true;
    }
  }

  fetchMN() {
    fetchM();
    fetchN();
  }
}
