import 'package:flutter/material.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../data/network/network_api_services.dart';
import '../models/chat_list_model.dart';

class ChatListService with ChangeNotifier {
  ChatListModel? _chatListModel;

  ChatListModel get chatListModel =>
      _chatListModel ??
      ChatListModel(activeUsers: [], profileImagePath: "", activityCheck: {});

  var token = "";

  var nextPage;

  bool nextPageLoading = false;

  bool nexLoadingFailed = false;

  bool get shouldAutoFetch => _chatListModel == null || token.isInvalid;

  fetchChatList() async {
    token = getToken;
    var url = AppUrls.chatListUrl;

    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.inbox, headers: acceptJsonAuthHeader);

    if (responseData != null) {
      var tempData = ChatListModel.fromJson(responseData);
      _chatListModel = tempData;
      notifyListeners();
      return true;
    }
  }

  void setChatRead(id) {
    _chatListModel?.chatList?.chats
        ?.firstWhere((element) => element.id.toString() == id.toString())
        .freelancerUnseenMsgCount = 0;
    notifyListeners();
  }

  void fetchNextPage() async {
    token = getToken;
    if (nextPageLoading) return;
    nextPageLoading = true;
    notifyListeners();
    final responseData = await NetworkApiServices()
        .getApi(nextPage, LocalKeys.jobList, headers: commonAuthHeader);

    if (responseData != null) {
      final tempData = ChatListModel.fromJson(responseData);
      tempData.chatList?.chats?.forEach((element) {
        _chatListModel?.chatList?.chats?.add(element);
      });
      nextPage = tempData.chatList?.nextPageUrl;
    } else {
      nexLoadingFailed = true;
      Future.delayed(const Duration(seconds: 1)).then((value) {
        nexLoadingFailed = false;
        notifyListeners();
      });
    }
    nextPageLoading = false;
    notifyListeners();
  }
}
