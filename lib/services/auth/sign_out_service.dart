import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/constant_helper.dart';
import '../../helper/local_keys.g.dart';

class SignOutService with ChangeNotifier {
  trySignOut() async {
    final responseData = await NetworkApiServices().postApi(
        {}, AppUrls.signOutUrl, LocalKeys.signOut,
        headers: commonAuthHeader);
    if (responseData != null) {
      LocalKeys.signOutComplete.showToast();
      setToken("");
      return true;
    }
  }
}
