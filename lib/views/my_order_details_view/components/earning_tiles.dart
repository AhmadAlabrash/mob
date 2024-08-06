import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/services/order_details_service.dart';

import '../../../helper/local_keys.g.dart';
import 'hourly_price_info_tile.dart';

class EarningTiles extends StatelessWidget {
  const EarningTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetailsService>(builder: (context, od, child) {
      final orderDetails = od.orderDetailsModel.orderDetails;
      if (orderDetails == null) {
        return const SizedBox();
      }
      return Column(
        children: [
          12.toHeight,
          HourlyPriceInfoTile(
                  price: orderDetails.commissionAmount,
                  priceNote: "",
                  status: LocalKeys.earnedBalance,
                  color: context.dProvider.gridColors[0],
                  desc: LocalKeys.earnedBalanceDesc)
              .hp20,
          12.toHeight,
          HourlyPriceInfoTile(
                  price: orderDetails.payableAmount,
                  priceNote: "",
                  status: LocalKeys.pendingBalance,
                  color: context.dProvider.gridColors[1],
                  desc: LocalKeys.pendingBalanceDesc)
              .hp20,
          12.toHeight,
          HourlyPriceInfoTile(
                  price: orderDetails.status.toString() == "3"
                      ? 0
                      : orderDetails.commissionAmount,
                  priceNote: "",
                  status: LocalKeys.commissionAmount,
                  color: context.dProvider.gridColors[2],
                  desc: LocalKeys.commissionBalanceDesc)
              .hp20,
          12.toHeight,
          HourlyPriceInfoTile(
                  price: orderDetails.price,
                  priceNote: "",
                  status: LocalKeys.totalBudget,
                  color: context.dProvider.gridColors[3],
                  desc: LocalKeys.totalBudgetDesc)
              .hp20,
        ],
      );
    });
  }
}
