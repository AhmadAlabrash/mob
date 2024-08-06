import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/my_order_list_service.dart';

class MyOrdersViewModel {
  ScrollController scrollController = ScrollController();
  MyOrdersViewModel._init();
  static MyOrdersViewModel? _instance;
  static MyOrdersViewModel get instance {
    _instance ??= MyOrdersViewModel._init();
    return _instance!;
  }

  MyOrdersViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  tryToLoadMore(BuildContext context) {
    try {
      final moProvider =
          Provider.of<MyOrderListService>(context, listen: false);
      final nextPage = moProvider.nextPage;
      final nextPageLoading = moProvider.nextPageLoading;

      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (nextPage != null && !nextPageLoading) {
          moProvider.fetchNextPage();
          return;
        }
      }
    } catch (e) {}
  }
}
