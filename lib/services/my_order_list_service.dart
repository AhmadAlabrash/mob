import 'package:flutter/material.dart';

import '../../helper/constant_helper.dart';
import '../../helper/extension/string_extension.dart';
import '../../helper/local_keys.g.dart';
import '../../models/my_orders_model.dart';
import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';

class MyOrderListService with ChangeNotifier {
  MyOrdersModel? _myOrdersModel;
  MyOrdersModel get myOrdersModel => _myOrdersModel ?? MyOrdersModel();
  List<Order>? orderList;
  var token = "";

  var nextPage;

  bool nextPageLoading = false;

  bool nexLoadingFailed = false;

  bool get shouldAutoFetch => orderList == null || token.isInvalid;

  fetchOrderList() async {
    token = getToken;
    debugPrint("fetching dashboard info".toString());
    final url = AppUrls.myOrdersListUrl;
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.orderList, headers: commonAuthHeader);

    if (responseData != null) {
      _myOrdersModel = MyOrdersModel.fromJson(responseData);
      orderList = myOrdersModel.ordersList?.data ?? [];
      nextPage = myOrdersModel.ordersList?.nextPageUrl;
    } else {
      orderList ??= [];
    }
    notifyListeners();
  }

  fetchNextPage() async {
    token = getToken;
    if (nextPageLoading) return;
    nextPageLoading = true;
    notifyListeners();
    final responseData = await NetworkApiServices()
        .getApi(nextPage, LocalKeys.orderList, headers: commonAuthHeader);

    if (responseData != null) {
      final tempData = MyOrdersModel.fromJson(responseData);
      tempData.ordersList?.data?.forEach((element) {
        orderList?.add(element);
      });
      nextPage = tempData.ordersList?.nextPageUrl;
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
