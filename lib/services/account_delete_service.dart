import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/constant_helper.dart';
import '../../helper/local_keys.g.dart';

class AccountDeleteService with ChangeNotifier {
  Future tryAccountDelete({password}) async {
    if (AppUrls.deleteAccountUrl.toLowerCase().contains("xilancer.xgenious")) {
      await Future.delayed(const Duration(seconds: 2));
      "This feature is turned off for demo app".showToast();
      return;
    }
    final responseData = await NetworkApiServices().postApi(
        {}, AppUrls.deleteAccountUrl, LocalKeys.deleteAccount,
        headers: acceptJsonAuthHeader);
    if (responseData != null) {
      responseData["msg"]?.toString().showToast();
      return true;
    }
  }
}
