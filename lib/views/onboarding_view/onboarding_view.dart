import 'package:flutter/material.dart';
import 'package:xilancer/customizations.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/views/home_drawer_view/home_drawer_view.dart';
import 'package:xilancer/views/my_orders_view/my_orders_view.dart';
import '../../helper/notification_helper.dart';
import '../bookmark_view/bookmark_view.dart';
import '../notifications_list_view/notifications_list_view.dart';
import '/view_models/onboarding_view_model/onboarding_view_model.dart';
import '/views/chat_list_view/chat_list_view.dart';
import '/views/profile_view/profile_view.dart';

import '/views/home_view/home_view.dart';
import 'components/onboarding_bottom_nav.dart';

class OnboardingView extends StatelessWidget {
  static const routeName = "landing";
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    final ov = OnboardingViewModel.instance;
    final widgets = [
      const HomeView(),
      const ChatListView(),
      const MyOrdersView(),
      const BookmarkView(),
      const ProfileView(),
      const NotificationListView(),
    ];
    return WillPopScope(
      onWillPop: ov.willPopFunction,
      child: Scaffold(
        key: ov.scaffoldKey,
        drawer: ValueListenableBuilder(
          valueListenable: ov.currentIndex,
          builder: (context, value, child) => value != 0
              ? const SizedBox(
                  width: 0,
                )
              : Drawer(
                  backgroundColor: context.dProvider.black9,
                  surfaceTintColor: context.dProvider.black9,
                  child: const HomeDrawerView(),
                ),
        ),
        body: ValueListenableBuilder(
          valueListenable: ov.currentIndex,
          builder: (context, value, child) => widgets[value],
        ),
        bottomNavigationBar: const OnboardingNavBar(),
      ),
    );
  }
}
