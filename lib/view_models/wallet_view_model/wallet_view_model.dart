import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/notifications_list_service.dart';
import '../../services/wallet_history_service.dart';

class WalletViewModel {
  final ScrollController scrollController = ScrollController();

  WalletViewModel._init();
  static WalletViewModel? _instance;
  static WalletViewModel get instance {
    _instance ??= WalletViewModel._init();
    return _instance!;
  }

  tryToLoadMore(BuildContext context) {
    try {
      final nlProvider =
          Provider.of<WalletHistoryService>(context, listen: false);
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
