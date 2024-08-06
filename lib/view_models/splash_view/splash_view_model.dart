import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/bookmark_data_service.dart';
import 'package:xilancer/services/chat_credential_service.dart';
import 'package:xilancer/services/profile_info_service.dart';
import 'package:xilancer/services/push_notification_service.dart';
import 'package:xilancer/view_models/sign_in_view/sign_in_view_model.dart';
import 'package:xilancer/views/sign_in_view/sign_in_view.dart';
import '../../helper/db_helper.dart';
import '../../helper/network_connectivity.dart';
import '../../helper/notification_helper.dart';
import '../../services/app_string_service.dart';
import '../../views/intro_view/intro_view.dart';
import '../../views/onboarding_view/onboarding_view.dart';
import '/services/intro_service.dart';

import '../../services/dynamics/dynamics_service.dart';

class SplashViewModel {
  dbInit(BuildContext context) {
    List databases = ['bookmark'];
    databases.map((e) => DbHelper.database(e));
    Provider.of<BookmarkDataService>(context, listen: false).fetchBookmarks();
  }

  initiateStartingSequence(BuildContext context) async {
    await coreInit(context);
    dbInit(context);
    final NetworkConnectivity networkConnectivity =
        NetworkConnectivity.instance;
    final hasConnection = await networkConnectivity.currentStatus();
    if (!hasConnection) {
      debugPrint("connection state is $hasConnection".toString());
      dProvider.setNoConnection(true);
      LocalKeys.noConnectionFound.showToast();
      return;
    }

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );

    await Provider.of<AppStringService>(context, listen: false)
        .translateStrings(context);
    await NotificationHelper().initiateNotification(context);
    NotificationHelper().streamListener(context);
    NotificationHelper().notificationAppLaunchChecker(context);
    final gotoIntro =
        await Provider.of<IntroService>(context, listen: false).checkIntro();
    debugPrint("intro is $gotoIntro".toString());
    if (gotoIntro) {
      await Provider.of<IntroService>(context, listen: false)
          .fetchIntro(context);
      context.toUntilPage(const IntroView());
      return;
    } else if (getToken.isEmpty) {
      SignInViewModel.instance.initSavedInfo();
      context.toNamed(SignInView.routeName);
      context.toUntilPage(const OnboardingView());
    } else {
      Provider.of<ProfileInfoService>(context, listen: false)
          .fetchProfileInfo()
          .then((value) async {
        Provider.of<ChatCredentialService>(context, listen: false)
            .fetchCredentials();
        await PushNotificationService().updateDeviceToken();
        context.toUntilPage(const OnboardingView());
      });
    }
  }
}
