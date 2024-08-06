import 'package:flutter/material.dart';
import 'package:xilancer/helper/constant_helper.dart';

import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../../customizations.dart' as cus;

class DynamicsService with ChangeNotifier {
  bool onceRebuilt = false;

  Color get primaryColor => cus.primaryColor;
  Color get whiteColor => cus.whiteColor;
  Color get blackColor => cus.blackColor;
  Color get hintColor => cus.hintColor;
  Color get borderColor => cus.borderColor;
  Color get secondaryColor => cus.secondaryColor;
  Color get warningColor => cus.warningColor;
  Color get greenColor => cus.greenColor;
  Color get yellowColor => cus.yellowColor;
  Color get gOneColor => cus.gOneColor;
  Color get gTwoColor => cus.gTwoColor;
  List<Color> get chatAvatarBGColors => cus.chatAvatarBGColors;
  List<Color> get statusColors => cus.statusColors;

  bool _noConnection = false;

  String languageSlug = 'en_GB';

  bool currencyRight = false;
  bool textDirectionRight = false;
  String currencySymbol = "\$";
  String currencyCode = "USD";
  get noConnection => _noConnection;
  get appLocal =>
      Locale(languageSlug.substring(0, 2), languageSlug.substring(3));

  List gridColors = [
    const Color(0xffE6F5DD),
    const Color(0xffFEF4EC),
    const Color(0xffF1F0FF),
    const Color(0xffDDF4FF),
  ];

  Color get black9 => const Color(0xffF2F4F7);
  Color get black8 => const Color(0xffEAECF0);
  Color get black7 => const Color(0xffD0D5DD);
  Color get black6 => const Color(0xff98A2B3);
  Color get black5 => const Color(0xff667085);
  Color get black4 => const Color(0xff475467);
  Color get black3 => const Color(0xff344054);
  Color get black2 => const Color(0xff1D2939);

  Color get primary05 => primaryColor.withOpacity(.05);
  Color get primary10 => primaryColor.withOpacity(.10);
  Color get primary20 => primaryColor.withOpacity(.20);
  Color get primary40 => primaryColor.withOpacity(.40);
  Color get primary60 => primaryColor.withOpacity(.60);
  Color get primary70 => primaryColor.withOpacity(.70);
  Color get primary80 => primaryColor.withOpacity(.80);

  setNoConnection(value) {
    if (value == noConnection) {
      return;
    }
    _noConnection = value;
    notifyListeners();
  }

  getColors() async {
    if (onceRebuilt) return;
    onceRebuilt = true;
    final responseData = await NetworkApiServices().getApi(
        AppUrls.currencyLanguageUrl, null,
        headers: acceptJsonAuthHeader);
    if (responseData != null) {
      languageSlug = responseData["languages"]?["slug"] ?? "en_GB";
      currencyRight = responseData["currencyPosition"] != "left";
      currencySymbol = responseData["symbol"] ?? "\$";
      currencyCode = responseData["currency_code"] ?? "USD";
      textDirectionRight = responseData["rtl"].toString() == "true";
    }
    notifyListeners();
  }
}
