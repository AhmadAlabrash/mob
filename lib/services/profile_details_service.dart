import 'package:flutter/material.dart';
import 'package:xilancer/data/network/network_api_services.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

import '../helper/local_keys.g.dart';
import '../models/profile_details_model.dart';

class ProfileDetailsService with ChangeNotifier {
  ProfileDetailsModel? _profileDetails;
  ProfileDetailsModel get profileDetails =>
      _profileDetails ?? ProfileDetailsModel();
  var token = "";
  var username = "";

  bool shouldAutoFetch(username) =>
      this.username != username || token.isInvalid;

  fetchProfileDetails({username}) async {
    final url = "${AppUrls.profileDetailsUrl}/$username";
    this.username = username;
    token = getToken;
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.profileDetails, headers: commonAuthHeader);
    if (responseData != null) {
      _profileDetails = ProfileDetailsModel.fromJson(responseData);
    }
    notifyListeners();
  }
}
