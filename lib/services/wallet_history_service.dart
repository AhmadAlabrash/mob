import 'package:flutter/material.dart';
import '../../helper/constant_helper.dart';
import '../../helper/extension/string_extension.dart';
import '../../helper/local_keys.g.dart';

import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';
import '../models/wallet_history_model.dart';

class WalletHistoryService with ChangeNotifier {
  WalletHistoryModel? _walletHistory;
  WalletHistoryModel get walletHistory =>
      _walletHistory ?? WalletHistoryModel();
  var token = "";
  bool loading = false;

  var nextPage;

  bool nextPageLoading = false;
  bool nexLoadingFailed = false;

  bool get shouldAutoFetch => _walletHistory == null || token.isInvalid;

  fetchWalletHistory() async {
    token = getToken;
    final responseData = await NetworkApiServices().getApi(
        AppUrls.walletHistoryUrl, LocalKeys.walletHistory.capitalize,
        headers: commonAuthHeader);

    if (responseData != null) {
      _walletHistory = WalletHistoryModel.fromJson(responseData);
      nextPage = walletHistory.histories?.nextPageUrl;
      debugPrint((_walletHistory?.histories?.data?.length).toString());
    } else {}
    notifyListeners();
  }

  fetchNextPage() async {
    token = getToken;
    debugPrint("next page loading for notification list".toString());
    if (nextPageLoading) return;
    nextPageLoading = true;
    final responseData = await NetworkApiServices().getApi(
        nextPage, LocalKeys.walletHistory.capitalize,
        headers: commonAuthHeader);

    if (responseData != null) {
      final tempData = WalletHistoryModel.fromJson(responseData);
      tempData.histories?.data?.forEach((element) {
        _walletHistory?.histories?.data?.add(element);
      });
      nextPage = tempData.histories?.nextPageUrl;
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
