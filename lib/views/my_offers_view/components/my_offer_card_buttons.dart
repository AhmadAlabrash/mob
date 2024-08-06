import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_button.dart';

import '../../../view_models/place_order_view_model/place_order_view_model.dart';
import '../../offer_details_view/offer_details_view.dart';
import '../../place_order_view/place_order_view.dart';

class MyOfferCardButton extends StatelessWidget {
  final bool fromDetails;
  final offerId;
  final offerStatus;
  const MyOfferCardButton({
    super.key,
    required this.offerId,
    required this.fromDetails,
    required this.offerStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!fromDetails)
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                context.toPage(OfferDetailsView(id: offerId));
              },
              child: Text(LocalKeys.viewDetails),
            ),
          ),
        if (offerStatus.toString() == "0") ...[
          8.toHeight,
          CustomButton(
            onPressed: () {
              PlaceOrderViewViewModel.dispose;
              context.toPage(PlaceOrderView(
                offerId: offerId,
              ));
            },
            btText: LocalKeys.acceptOffer,
            isLoading: false,
          ),
        ]
      ],
    );
  }
}
