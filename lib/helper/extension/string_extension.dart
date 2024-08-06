import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:crypto/crypto.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xilancer/customizations.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../constant_helper.dart';

extension SvgPathExtension on String {
  Widget get toSVG => SvgPicture.asset('assets/svg/$this.svg');
}

extension SvgSizedExtension on String {
  Widget toSVGSized(double height, {color}) => SvgPicture.asset(
        'assets/svg/$this.svg',
        height: height,
        color: color,
      );
}

extension StringExtension on String {
  String get capitalize {
    final laterPart = substring(1);
    return "${this[0].toUpperCase()}${laterPart.toLowerCase()}";
  }

  num get tryToParse {
    RegExp numberPattern = RegExp(r'\d+(\.\d+)?');

    // Replace all matches with an empty string
    String originalCurrency = replaceAll(",", "").replaceAll(numberPattern, '');
    return num.tryParse(replaceAll(originalCurrency, "")
            .replaceAll(",", "")
            .replaceAll(dProvider.currencySymbol.toString(), "")) ??
        0;
  }
}

extension NumConversionExtension on Object {
  num get tryToParse {
    RegExp numberPattern = RegExp(r'\d+(\.\d+)?');
    final objString = toString();
    // Replace all matches with an empty string
    String originalCurrency =
        objString.replaceAll(",", "").replaceAll(numberPattern, '');
    return num.tryParse(objString
            .replaceAll(originalCurrency, "")
            .replaceAll(",", "")
            .replaceAll(dProvider.currencySymbol.toString(), "")) ??
        0;
  }
}

extension NumConversionExtensionD on dynamic {
  num get tryToParse {
    RegExp numberPattern = RegExp(r'\d+(\.\d+)?');
    final objString = toString();
    // Replace all matches with an empty string
    String originalCurrency =
        objString.replaceAll(",", "").replaceAll(numberPattern, '');
    return num.tryParse(objString
            .replaceAll(originalCurrency, "")
            .replaceAll(",", "")
            .replaceAll(dProvider.currencySymbol.toString(), "")) ??
        0;
  }
}

extension CurrencyDynamicExtension on String {
  String get cur {
    String symbol = dProvider.currencySymbol;
    return dProvider.currencyRight ? "$this$symbol" : "$symbol$this";
  }
}

extension TranslateExtension on String {
  String tr() {
    return asProvider.getString(this);
  }
}

extension EmailValidateExtension on String {
  bool get validateEmail {
    final emailReg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailReg.hasMatch(this);
  }
}

extension ShowToastExtension on String {
  showToast({bc, tc}) {
    print("trying to show toast");
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: asProvider.getString(this),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: bc ?? dProvider.blackColor,
        textColor: tc ?? dProvider.whiteColor,
        fontSize: 16.0);
  }
}

extension CapitalizeWordsExtension on String {
  String get capitalizeWords {
    if (isEmpty) {
      return '';
    }

    List<String> words = split(' ');
    List<String> capitalizedWords = [];

    for (String word in words) {
      if (word.isNotEmpty) {
        String capitalized = word[0].toUpperCase() + word.substring(1);
        capitalizedWords.add(capitalized);
      }
    }

    return capitalizedWords.join(' ');
  }
}

extension TokenValidateExtension on String {
  bool get isInvalid {
    return this != getToken;
  }
}

extension OrderStatusExtension on String {
  String get getStatus {
    switch (this) {
      case "0":
        return LocalKeys.pendingOrder;
      case "1":
        return LocalKeys.activeOrder;
      case "2":
        return LocalKeys.orderDelivered;
      case "3":
        return LocalKeys.completeOrder;
      case "4":
        return LocalKeys.canceledOrder;
      case "5":
        return LocalKeys.orderDeclined;
      case "6":
        return LocalKeys.orderSuspended;
      case "7":
        return LocalKeys.orderOnHold;
      default:
        return LocalKeys.pending;
    }
  }
}

extension MilestoneStatusExtension on String {
  String get getMStatus {
    switch (this) {
      case "0":
        return LocalKeys.pending;

      case "1":
        return LocalKeys.active;
      case "2":
        return LocalKeys.complete;
      case "3":
        return LocalKeys.cancel;
      case "4":
        return LocalKeys.delivered;
      default:
        return LocalKeys.pending;
    }
  }
}

extension WSHistoryStatusExtension on String {
  String get getWSHStatus {
    switch (this) {
      case "0":
        return LocalKeys.pending;
      case "1":
        return LocalKeys.approved;
      case "2":
        return LocalKeys.requestedRevision;
      default:
        return LocalKeys.pending;
    }
  }
}

extension PasswordValidatorExtension on String {
  String? get validPass {
    String? value;
    if (length < 8) {
      value = LocalKeys.passLeastCharWarning.tr();
    } else if (!RegExp(r'[A-Z]').hasMatch(this)) {
      value = LocalKeys.passUpperCaseWarning.tr();
    } else if (!RegExp(r'[a-z]').hasMatch(this)) {
      value = LocalKeys.passLowerCaseWarning.tr();
    } else if (!RegExp(r'\d').hasMatch(this)) {
      value = LocalKeys.passDigitWarning.tr();
    } else if (!RegExp(r'[@$!%*?&]').hasMatch(this)) {
      value = LocalKeys.passCharacterWarning.tr();
    }
    debugPrint(value.toString());
    return value;
  }
}

extension AssetExtension on String {
  Widget toAImage({color, fit}) => Image.asset(
        'assets/images/$this.png',
        fit: fit,
      );
  String get profileImage => "$userProfilePath/$this";
  String get jobProposalAttachment => "$jobProposalAssetPath/$this";
}

extension AssetImageExtension on String {
  ImageProvider get toAsset => AssetImage(
        'assets/images/$this.png',
      );
}

extension EncryptionExtension on String {
  String toHmac({required String secret}) {
    final keyBytes = const Utf8Encoder().convert(secret);
    final dataBytes = const Utf8Encoder().convert(this);

    final hmacBytes = Hmac(sha256, keyBytes).convert(dataBytes);
    return hmacBytes.toString();
  }
}
