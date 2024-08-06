import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/models/notification_list_model.dart';
import 'package:xilancer/services/notifications_list_service.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/empty_widget.dart';
import 'package:xilancer/view_models/notifications_list_view_model/notifications_list_view_model.dart';
import 'package:xilancer/views/notifications_list_view/components/notification_list_skeleton.dart';
import 'package:xilancer/views/notifications_list_view/components/notification_list_tile.dart';

import '../../services/profile_info_service.dart';
import '../account_skeleton/account_skeleton.dart';

class NotificationListView extends StatelessWidget {
  const NotificationListView({super.key});

  @override
  Widget build(BuildContext context) {
    final nlm = NotificationsListViewModel.instance;
    nlm.scrollController.addListener(() {
      nlm.tryToLoadMore(context);
    });
    final nlProvider =
        Provider.of<NotificationsListService>(context, listen: false);
    return Column(
      children: [
        AppBar(
          leadingWidth: 0,
          leading: const SizedBox(),
          title: Text(LocalKeys.notifications),
        ),
        4.toHeight,
        Consumer<ProfileInfoService>(builder: (context, pi, child) {
          return Expanded(
              child: pi.profileInfoModel.data == null
                  ? Column(
                      children: [
                        12.toHeight,
                        const Expanded(child: AccountSkeleton()),
                        16.toHeight,
                      ],
                    )
                  : CustomRefreshIndicator(
                      onRefresh: () async {
                        await nlProvider.fetchNotificationsList();
                      },
                      child: CustomFutureWidget(
                          function: nlProvider.shouldAutoFetch
                              ? nlProvider.fetchNotificationsList()
                              : null,
                          shimmer: const NotificationListSkeleton(),
                          child: Consumer<NotificationsListService>(
                              builder: (context, nl, child) {
                            nl.updateNotification(context);
                            return Scrollbar(
                              controller: nlm.scrollController,
                              child: nl.notificationsList.notifications
                                          ?.isEmpty ??
                                      true
                                  ? EmptyWidget(
                                      title: LocalKeys.noNotificationYet)
                                  : ListView.separated(
                                      controller: nlm.scrollController,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20),
                                      itemBuilder: (context, index) {
                                        if (nl.nextPage != null &&
                                            (nl.notificationsList.notifications!
                                                    .length) ==
                                                index) {
                                          return const CustomPreloader();
                                        }
                                        final nItem = nl.notificationsList
                                            .notifications![index];
                                        return NotificationListTile(
                                          title: nItem.message ?? "---",
                                          date:
                                              nItem.createdAt ?? DateTime.now(),
                                          type: nItem.type,
                                          isRead: nItem.isRead == IsRead.UNREAD,
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          4.toHeight,
                                      itemCount:
                                          (nl.notificationsList.notifications ??
                                                      [])
                                                  .length +
                                              (nl.nextPage != null &&
                                                      !nl.nexLoadingFailed
                                                  ? 1
                                                  : 0)),
                            );
                          })),
                    ));
        })
      ],
    );
  }
}
