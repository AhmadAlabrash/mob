import 'package:flutter/material.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';

import '../data/network/network_api_services.dart';

class ChatCredentialService with ChangeNotifier {
  var appId = "";
  var appKey = "";
  var appSecret = "";
  var appCluster = "";

  fetchCredentials() async {
    var url = AppUrls.chatCredentialUrl;

    final responseData = await NetworkApiServices().getApi(
      url,
      null,
      headers: acceptJsonAuthHeader,
    );

    if (responseData != null) {
      appId = responseData["pusher_app_id"];
      appKey = responseData["pusher_app_key"];
      appSecret = responseData["pusher_app_secret"];
      appCluster = responseData["pusher_app_cluster"];
      return true;
    }
  }
}
