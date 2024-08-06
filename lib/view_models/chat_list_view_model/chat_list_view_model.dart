import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/chat_list_service.dart';

class ChatListViewModel {
  final ScrollController scrollController = ScrollController();
  final ValueNotifier<String?> nextPage = ValueNotifier('_value');
  final ValueNotifier<bool> nextPageLoading = ValueNotifier(false);

  ChatListViewModel._init();
  static ChatListViewModel? _instance;
  static ChatListViewModel get instance {
    _instance ??= ChatListViewModel._init();
    return _instance!;
  }

  tryLoadingMore(BuildContext context) async {
    try {
      final cl = Provider.of<ChatListService>(context, listen: false);
      final nextPage = cl.nextPage;
      final nextPageLoading = cl.nextPageLoading;

      if (scrollController.offset ==
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (nextPage != null && !nextPageLoading) {
          cl.fetchNextPage();
          return;
        }
      }
    } catch (e) {}
  }
}
