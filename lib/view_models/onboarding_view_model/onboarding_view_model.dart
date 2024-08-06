import 'package:flutter/material.dart';
import '/helper/extension/string_extension.dart';
import '/helper/local_keys.g.dart';

class OnboardingViewModel {
  DateTime? currentBackPressTime;
  // PageController pageController = PageController();
  ValueNotifier currentIndex = ValueNotifier(0);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  OnboardingViewModel._init();
  static OnboardingViewModel? _instance;
  static OnboardingViewModel get instance {
    _instance ??= OnboardingViewModel._init();
    return _instance!;
  }

  OnboardingViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  void setNavIndex(int value) async {
    if (value == currentIndex.value) {
      return;
    }
    currentIndex.value = value;
  }

  void setNavIndexP(int value) {
    if (value == currentIndex.value) {
      return;
    }
    currentIndex.value = value;
  }

  Future<bool> willPopFunction() async {
    if (currentIndex.value != 0) {
      currentIndex.value = 0;
      return Future.value(false);
    }

    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      LocalKeys.pressAgainToExit.showToast();
      return Future.value(false);
    }
    return Future.value(true);
  }
}
