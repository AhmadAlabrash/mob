import 'package:flutter/material.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../data/network/network_api_services.dart';
import '../models/offer_details_model.dart';

class OfferDetailsService with ChangeNotifier {
  OfferDetailsModel? _offerDetailsModel;
  OfferDetailsModel get offerDetailsModel =>
      _offerDetailsModel ??
      OfferDetailsModel(avgRating: 0, completeOrdersCount: 0, ratingCount: 0);

  String token = '';

  bool shouldAutoFetch(id) =>
      offerDetailsModel.offerDetails?.id?.toString() != id.toString() ||
      token.isInvalid;

  fetchOfferDetail(id) async {
    token = getToken;
    var url = "${AppUrls.offerDetailsUrl}/$id";

    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.offerDetails, headers: acceptJsonAuthHeader);

    if (responseData != null) {
      final tempDetails = OfferDetailsModel.fromJson(responseData);
      _offerDetailsModel = tempDetails;
      return true;
    }
  }
}
