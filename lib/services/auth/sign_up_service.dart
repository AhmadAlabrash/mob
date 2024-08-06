import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/constant_helper.dart';
import '../../helper/local_keys.g.dart';

class SignUpService with ChangeNotifier {
  var emailToken = "";
  var userId = "";
  var token = "";
  Future trySignUp({
    required String firstName,
    required String lastName,
    required String userName,
    required String email,
    required String phone,
    required String password,
  }) async {
    final data = {
      'first_name': firstName,
      'last_name': lastName,
      'username': userName,
      'email': email,
      'phone': phone,
      'password': password,
      'confirm_password': password
    };
    final responseData = await NetworkApiServices().postApi(
      data,
      AppUrls.signUpUrl,
      LocalKeys.signUp,
    );

    if (responseData != null) {
      LocalKeys.signedInSuccessfully.showToast();
      token = responseData["token"];
      emailToken = responseData["user"]["email_verify_token"];
      userId = responseData["user"]["id"].toString();
      return true;
    }
  }

  tryConfirmingEmail({otpCode, id}) async {
    final data = {
      'user_id': id ?? userId,
      'otp_code': otpCode,
    };
    final responseData = await NetworkApiServices().postApi(
      data,
      AppUrls.emailVerifyUrl,
      LocalKeys.emailVerify,
    );

    if (responseData != null) {
      LocalKeys.emailVerifiedSuccessfully.showToast();
      return true;
    }
  }
}
