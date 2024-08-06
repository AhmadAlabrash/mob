import 'package:flutter/material.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';
import '../helper/local_keys.g.dart';
import '../models/order_details_model.dart';

class OrderDetailsService with ChangeNotifier {
  OrderDetailsModel? _orderDetailsModel;

  OrderDetailsModel get orderDetailsModel =>
      _orderDetailsModel ?? OrderDetailsModel();

  String token = "";

  bool shouldAutoFetch(id) =>
      _orderDetailsModel?.orderDetails?.id.toString() != id.toString() ||
      token.isInvalid;

  fetchOrderDetails({required orderId}) async {
    token = getToken;
    _orderDetailsModel = null;
    token = getToken;
    final url = "${AppUrls.orderDetailsUrl}/${orderId.toString()}";
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.orderDetails, headers: commonAuthHeader);

    if (responseData != null) {
      _orderDetailsModel = OrderDetailsModel.fromJson(responseData);
    } else {}
    notifyListeners();
  }

  tryAcceptingWork({
    required orderId,
    milestoneId,
  }) async {
    var url = AppUrls.acceptOrderUrl;
    var data = {
      'order_id': orderId?.toString() ?? "",
      'order_milestone_id': milestoneId?.toString() ?? "",
    };

    final responseData = await NetworkApiServices().postApi(
        data, url, LocalKeys.acceptOrder,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      orderDetailsModel.orderDetails?.orderSubmitHistory?.lastOrNull?.status =
          1;
      try {
        orderDetailsModel.orderMileStones
            ?.firstWhere(
                (element) => element.id.toString() == milestoneId.toString())
            .status = 2;
      } catch (e) {}
      notifyListeners();
      return true;
    }
  }

  tryRequestingRevision(
      {orderId, orderWorkId, description, milestoneId}) async {
    var url = AppUrls.requestRevisionUrl;
    var data = {
      'order_id': '$orderId',
      'order_milestone_id': milestoneId?.toString() ?? "",
      'order_submit_history_id': '$orderWorkId',
      'revision_description': '$description'
    };

    final responseData = await NetworkApiServices().postApi(
        data, url, LocalKeys.acceptOrder,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      orderDetailsModel.orderDetails?.orderSubmitHistory?.lastOrNull?.status =
          2;
      try {
        orderDetailsModel.orderMileStones
            ?.firstWhere(
                (element) => element.id.toString() == milestoneId.toString())
            .status = 1;
      } catch (e) {}
      LocalKeys.revisionRequestedSuccessfully.showToast();
      notifyListeners();
      return true;
    }
  }
}
