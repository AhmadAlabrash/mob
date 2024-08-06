import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xilancer/customizations.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/models/order_details_model.dart';
import 'package:xilancer/view_models/project_details_view_model/project_details_view_model.dart';

import '../data/network/network_api_services.dart';
import '../view_models/place_order_view_model/place_order_view_model.dart';

class PlaceOrderService with ChangeNotifier {
  var orderResponse;
  var orderId;
  num amount = 0;

  projectPlaceOrder({
    projectId,
    offerId,
    proposalId,
    jobId,
  }) async {
    final pom = PlaceOrderViewViewModel.instance;
    final pd = ProjectDetailsViewModel.instance;
    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrls.placeOrderUrl));
    request.fields.addAll({
      'selected_payment_gateway':
          pom.walletSelect.value ? "wallet" : pom.selectedGateway.value!.name,
      'project_id': projectId?.toString() ?? "",
      'job_id_for_order': jobId?.toString() ?? "",
      'proposal_id_for_order': proposalId?.toString() ?? "",
      'offer_id_for_order': offerId?.toString() ?? "",
      'basic_standard_premium_type': pd.selectedProject,
      'order_description': pom.descriptionController.text,
    });
    var mileStones = [];
    if (pom.addMilestones.value) {
      for (var i = 0; i < pom.milestones.value.length; i++) {
        var mileStone = pom.milestones.value[i];
        mileStones.add({
          'milestone_title': mileStone.name,
          'milestone_description': mileStone.description ?? "",
          'milestone_price': mileStone.price.toString(),
          'milestone_revision': mileStone.revision.toString(),
          'milestone_deadline': mileStone.dTime,
        });
      }
      request.fields.addAll({
        'pay_by_milestone': 'pay-by-milestone',
        "milestones": jsonEncode(mileStones),
      });
    }
    if (pom.selectedGateway.value?.name == "manual_payment" &&
        pom.selectedAttachment.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'manual_payment_image', pom.selectedAttachment.value!.path));
    }
    request.headers.addAll(acceptJsonAuthHeader);

    debugPrint(request.fields.toString());
    // return;
    final responseData = await NetworkApiServices()
        .postWithFileApi(request, LocalKeys.placeOrder);

    if (responseData != null) {
      var tempOD = OrderDetailsModel.fromJson(responseData);
      orderResponse = tempOD;
      orderId = tempOD.orderDetails?.id;
      amount = (tempOD.orderDetails?.price).toString().tryToParse;
      return true;
    }
  }

  updatePayment(orderId, String userEmail) async {
    var url = AppUrls.updatePaymentUrl;
    var data = {
      "order_id": orderId.toString(),
      "status": "1",
      "secret_key": userEmail.toHmac(secret: paymentUpdateEncryptionKey),
    };

    final responseData = await NetworkApiServices().postApi(
        data, url, LocalKeys.paymentSuccess,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      return true;
    }
  }
}
