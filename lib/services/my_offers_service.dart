import 'package:flutter/material.dart';

import '../../helper/constant_helper.dart';
import '../../helper/extension/string_extension.dart';
import '../../helper/local_keys.g.dart';
import '../../models/my_offers_model.dart';
import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';

class MyOffersService with ChangeNotifier {
  MyOffersModel? _myOffersModel;
  MyOffersModel get myOffersModel => _myOffersModel ?? MyOffersModel();
  List<Offer>? offerList;
  var token = "";

  var nextPage;

  bool nextPageLoading = false;

  bool nexLoadingFailed = false;

  bool get shouldAutoFetch => offerList == null || token.isInvalid;

  fetchOrderList() async {
    token = getToken;
    debugPrint("fetching dashboard info".toString());
    final url = AppUrls.myOffersUrl;
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.myOffers, headers: commonAuthHeader);

    if (responseData != null) {
      _myOffersModel = MyOffersModel.fromJson(responseData);
      offerList = myOffersModel.myOffers?.data ?? [];
      nextPage = myOffersModel.myOffers?.nextPageUrl;
    } else {
      offerList ??= [];
    }
    notifyListeners();
  }

  fetchNextPage() async {
    token = getToken;
    if (nextPageLoading) return;
    nextPageLoading = true;
    notifyListeners();
    final responseData = await NetworkApiServices()
        .getApi(nextPage, LocalKeys.myOffers, headers: commonAuthHeader);

    if (responseData != null) {
      final tempData = MyOffersModel.fromJson(responseData);
      tempData.myOffers?.data?.forEach((element) {
        offerList?.add(element);
      });
      nextPage = tempData.myOffers?.nextPageUrl;
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
