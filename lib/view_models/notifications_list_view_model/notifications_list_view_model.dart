import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/notifications_list_service.dart';

class NotificationsListViewModel {
  final ScrollController scrollController = ScrollController();

  NotificationsListViewModel._init();
  static NotificationsListViewModel? _instance;
  static NotificationsListViewModel get instance {
    _instance ??= NotificationsListViewModel._init();
    return _instance!;
  }

  tryToLoadMore(BuildContext context) {
    try {
      final nlProvider =
          Provider.of<NotificationsListService>(context, listen: false);
      final nextPage = nlProvider.nextPage;
      final nextPageLoading = nlProvider.nextPageLoading;

      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (nextPage != null && !nextPageLoading) {
          nlProvider.fetchNextPage();
          return;
        }
      }
    } catch (e) {}
  }
}
