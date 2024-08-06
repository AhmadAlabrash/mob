import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:xilancer/services/profile_info_service.dart';
import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/constant_helper.dart';
import '../../helper/extension/string_extension.dart';
import '../../helper/local_keys.g.dart';

class ProfileEditService with ChangeNotifier {
  tryUpdatingProfile(BuildContext context, firstName, lastName, email, phone,
      experience, countryId, stateId, cityId, File? image) async {
    var requestInfo =
        http.MultipartRequest('POST', Uri.parse(AppUrls.profileInfoUpdate));
    var requestImage =
        http.MultipartRequest('POST', Uri.parse(AppUrls.profileImageUpdate));
    final pi = Provider.of<ProfileInfoService>(context, listen: false)
        .profileInfoModel
        .data;
    Map<String, String> updateData = {
      'first_name': firstName,
      'last_name': lastName,
      'level': experience,
      'email': email,
      'country': "$countryId",
      'state': "$stateId",
      'city': "$cityId",
      "phone": phone
    };
    Map<String, String> prevData = {
      'first_name': pi?.firstName ?? "",
      'last_name': pi?.lastName ?? "",
      'level': pi?.experienceLevel ?? "",
      'email': pi?.email ?? "",
      'country': "${pi?.countryId}",
      'state': "${pi?.stateId}",
      'city': "${pi?.cityId}",
      "phone": pi?.phone ?? "",
    };
    requestInfo.fields.addAll(updateData);

    requestInfo.headers.addAll(commonAuthHeader);
    requestInfo.headers.putIfAbsent('Accept', () => 'application/json');
    Map? responseInfoData;
    Map? responseImageData;
    if (jsonEncode(updateData) != jsonEncode(prevData)) {
      responseInfoData = await NetworkApiServices()
          .postWithFileApi(requestInfo, LocalKeys.editProfile);
    } else {
      responseInfoData = {};
      debugPrint('Skipping info update'.toString());
    }
    if (AppUrls.profileInfoUpdate.toLowerCase().contains("xilancer.xgenious")) {
      await Future.delayed(const Duration(seconds: 2));
      "This feature is turned off for demo app".showToast();
      return;
    }

    requestImage.headers.addAll(commonAuthHeader);
    requestImage.headers.putIfAbsent('Accept', () => 'application/json');
    if (image != null) {
      requestImage.files.add(await http.MultipartFile.fromPath(
        'image',
        image.path,
      ));
      LocalKeys.uploadingMediaFileMightTakeSomeTime.showToast();
      responseImageData = await NetworkApiServices()
          .postWithFileApi(requestImage, LocalKeys.editProfile);
    } else {
      responseImageData = {};
    }

    if (responseInfoData != null && responseImageData != null) {
      LocalKeys.profileInfoUpdated.showToast();
      return true;
    }

    if (image == null && jsonEncode(updateData) == jsonEncode(prevData)) {
      LocalKeys.nothingToChange.showToast();
    }
  }
}
