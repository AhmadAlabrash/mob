import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/view_models/my_order_details_view_model/my_order_details_view_model.dart';

import '../../../utils/components/custom_button.dart';

class OrderDetailsButtons extends StatelessWidget {
  final orderAccepted;
  const OrderDetailsButtons({super.key, this.orderAccepted = false});

  @override
  Widget build(BuildContext context) {
    final modm = MyOrderDetailsViewModel.instance;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {},
            child: Text(LocalKeys.reportOrder),
          ).hp20,
        ),
        8.toHeight,
        SizedBox(
          width: double.infinity,
          child: CustomButton(
            onPressed: () {
              if (!orderAccepted) {
                modm.tryDeclineOrder(context);
                return;
              }
              modm.tryCancelOrder(context);
            },
            btText:
                orderAccepted ? LocalKeys.cancelOrder : LocalKeys.declineOrder,
            isLoading: false,
            backgroundColor: context.dProvider.warningColor,
          ).hp20,
        ),
        if (!orderAccepted) 8.toHeight,
        if (!orderAccepted)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                    onPressed: () {
                      modm.tryAcceptOrder(context);
                    },
                    child: Text(LocalKeys.acceptOrder))
                .hp20,
          ),
      ],
    );
  }
}
