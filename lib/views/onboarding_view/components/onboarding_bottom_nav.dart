import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:badges/badges.dart' as badges;
import 'package:xilancer/services/bookmark_data_service.dart';
import 'package:xilancer/services/message_notification_count_service.dart';
import '../../../helper/local_keys.g.dart';
import '../../../helper/svg_assets.dart';
import '/helper/extension/context_extension.dart';
import '/helper/extension/string_extension.dart';
import '/view_models/onboarding_view_model/onboarding_view_model.dart';

class OnboardingNavBar extends StatelessWidget {
  const OnboardingNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final ov = OnboardingViewModel.instance;
    return ValueListenableBuilder(
        valueListenable: ov.currentIndex,
        builder: (context, value, child) => Container(
              decoration: BoxDecoration(
                color: context.dProvider.whiteColor,
                border: Border(
                    top: BorderSide(color: context.dProvider.black8, width: 2)),
              ),
              child: SizedBox(
                height: context.width > 500 ? 40 : 72,
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      navBarItem(context, LocalKeys.home, SvgAssets.home,
                          SvgAssets.homeBold, 0, ov),
                      Consumer<MessageNotificationCountService>(
                          builder: (context, mnc, child) {
                        return navBarItem(context, LocalKeys.inbox,
                            SvgAssets.message, SvgAssets.messageBold, 1, ov,
                            badgeCount: mnc.messageCount);
                      }),
                      navBarItem(
                          context,
                          LocalKeys.myOrder,
                          SvgAssets.clipboardText,
                          SvgAssets.clipboardTextBold,
                          2,
                          ov),
                      Consumer<BookmarkDataService>(
                          builder: (context, bd, child) {
                        return navBarItem(context, LocalKeys.bookmark,
                            SvgAssets.bookmark, SvgAssets.bookmarkBold, 3, ov,
                            badgeCount: bd.bookmarkList.length);
                      }),
                      navBarItem(context, LocalKeys.profile, SvgAssets.user,
                          SvgAssets.userBold, 4, ov),
                      Consumer<MessageNotificationCountService>(
                          builder: (context, mnc, child) {
                        return navBarItem(
                            context,
                            LocalKeys.notification,
                            SvgAssets.notification,
                            SvgAssets.notificationBold,
                            5,
                            ov,
                            badgeCount: mnc.notificationCount);
                      }),
                    ],
                  ),
                ),
              ),
            ));
  }

  navBarItem(BuildContext context, String label, String iconNormal,
      String iconFilled, int index, ov,
      {badgeCount = 0}) {
    final selected = index == ov.currentIndex.value;
    return InkWell(
      onTap: () {
        ov.setNavIndex(index);
      },
      child: Container(
        height: 32,
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        constraints: BoxConstraints(minWidth: selected ? 132 : 0.0),
        decoration: selected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: context.dProvider.primary10,
                border:
                    Border.all(color: context.dProvider.primaryColor, width: 2),
              )
            : null,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          (selected
              ? iconFilled.toSVGSized(20, color: context.dProvider.primaryColor)
              : badges.Badge(
                  position: badges.BadgePosition.topEnd(),
                  badgeContent: Text(
                    "$badgeCount",
                    style: context.titleSmall
                        ?.copyWith(color: context.dProvider.whiteColor),
                  ),
                  showBadge: badgeCount > 0,
                  child: SizedBox(
                    height: 72,
                    child: iconNormal.toSVGSized(20),
                  ))),
          if (selected) 4.toWidth,
          if (selected)
            Text(
              label,
              style: context.titleSmall
                  ?.copyWith(color: context.dProvider.primaryColor)
                  .bold6,
            )
        ]),
      ),
    );
  }
}
