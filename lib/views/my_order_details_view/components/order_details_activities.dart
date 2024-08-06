import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import 'order_activity_info.dart';

class OrderDetailsActivity extends StatelessWidget {
  const OrderDetailsActivity({super.key});

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
            LocalKeys.activities,
            style: context.titleMedium?.bold6,
          ).hp20,
          20.toHeight,
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 16,
          ),
          const OrderActivityInfo(),
          const OrderActivityInfo(),
          const OrderActivityInfo(),
          const OrderActivityInfo(
            isLast: true,
          ),
        ],
      ),
    );
  }
}
