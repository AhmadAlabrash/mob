import 'package:flutter/material.dart';

class WithdrawRequestsViewModel {
  final ScrollController scrollController = ScrollController();
  final ValueNotifier<String?> nextPage = ValueNotifier('_value');
  final ValueNotifier<int?> selectedIndex = ValueNotifier(null);
  final ValueNotifier<bool> nextPageLoading = ValueNotifier(false);
  ExpansionTileController? expansionTileController;

  WithdrawRequestsViewModel._init();
  static WithdrawRequestsViewModel? _instance;
  static WithdrawRequestsViewModel get instance {
    _instance ??= WithdrawRequestsViewModel._init();
    return _instance!;
  }

  toggleInfoView(index, ExpansionTileController controller) {
    if (selectedIndex.value == index) {
      selectedIndex.value = null;
      expansionTileController = null;
      return;
    }
    try {
      if (expansionTileController != null &&
          (expansionTileController?.isExpanded ?? false == true)) {
        expansionTileController?.collapse();
      }
    } catch (e) {
      expansionTileController = null;
    }
    expansionTileController = controller;
    selectedIndex.value = index;
  }

  tryToLoadMore(BuildContext context) {
    try {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (nextPage.value == null) {
          return;
        }
        if (nextPage.value != null && !nextPageLoading.value) {
          return;
        }
      }
    } catch (e) {}
  }
}
