import 'package:flutter/material.dart';
import 'package:path/path.dart';
import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/constant_helper.dart';
import '../../helper/extension/string_extension.dart';
import '../../helper/local_keys.g.dart';

class ChangePasswordService with ChangeNotifier {
  tryChangingPassword({oldPass, newPass}) async {
    final data = {
      'current_password': '$oldPass',
      'new_password': '$newPass',
      'confirm_new_password': '$newPass'
    };
    if (AppUrls.changePasswordUrl.toLowerCase().contains("xilancer.xgenious")) {
      await Future.delayed(const Duration(seconds: 2));
      "This feature is turned off for demo app".showToast();
      return;
    }
    final responseData = await NetworkApiServices().postApi(
        data, AppUrls.changePasswordUrl, LocalKeys.changePassword,
        headers: commonAuthHeader);

    if (responseData != null) {
      LocalKeys.passwordChangedSuccessfully.showToast();
      return true;
    }
  }
}
