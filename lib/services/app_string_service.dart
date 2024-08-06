import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';
import '../helper/constant_helper.dart';
import '../helper/local_keys.g.dart';

class AppStringService with ChangeNotifier {
  var translatedString = {};
  String getString(String s) {
    if (translatedString[s] != null && translatedString[s].isNotEmpty) {
      return translatedString[s];
    }
    return s;
  }

  translateStrings(BuildContext context) async {
    bool shouldLoad = true;
    if (!sPref!.containsKey('langId')) {
      debugPrint("Translating Strings".toString());
      sPref!.setString('langId', dProvider.languageSlug);
    } else if (sPref!.getString('langId') != dProvider.languageSlug) {
      debugPrint('Updating translated Strings');
      sPref!.setString('langId', dProvider.languageSlug);
    } else {
      debugPrint("Skipping online translation".toString());
      shouldLoad = false;
    }

    if (!shouldLoad) {
      final strings = sPref!.getString('translated_string');
      translatedString = jsonDecode(strings ?? '{}');
      coreInit(context);
      return;
    }

    final data = {"strings": jsonEncode(LocalKeys.stringsMap)};
    final responseData = await NetworkApiServices()
        .postApi(data, AppUrls.translationUrl, LocalKeys.translatingText);

    if (responseData != null) {
      debugPrint((responseData["strings"] is Map).toString());
      translatedString =
          responseData["strings"] is! Map ? {} : responseData["strings"];
      sPref?.setString("translated_string", jsonEncode(translatedString));
      coreInit(context);
    } else {}
  }
}
