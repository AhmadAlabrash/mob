import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/my_offers_service.dart';

class MyOffersViewModel {
  ScrollController scrollController = ScrollController();

  MyOffersViewModel._init();
  static MyOffersViewModel? _instance;
  static MyOffersViewModel get instance {
    _instance ??= MyOffersViewModel._init();
    return _instance!;
  }

  MyOffersViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  tryToLoadMore(BuildContext context) {
    try {
      final moProvider = Provider.of<MyOffersService>(context, listen: false);
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
