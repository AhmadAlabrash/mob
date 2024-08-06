import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/views/my_order_details_view/components/order_details_buttons.dart';

import '../../../utils/components/custom_button.dart';

class OrderDetailsDescription extends StatelessWidget {
  final description;
  const OrderDetailsDescription({super.key, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalKeys.orderDescription,
            style: context.titleMedium?.bold6,
          ).hp20,
          8.toHeight,
          Text(
            description ?? LocalKeys.noDescriptionAvailable,
            style:
                context.titleSmall?.copyWith(color: context.dProvider.black5),
          ).hp20,
        ],
      ),
    );
  }
}
