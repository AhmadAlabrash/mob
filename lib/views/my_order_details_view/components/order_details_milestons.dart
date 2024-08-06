import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/order_details_service.dart';

import 'order_details_milestone_card.dart';

class OrderDetailsMilestone extends StatelessWidget {
  const OrderDetailsMilestone({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderDetailsService>(builder: (context, od, child) {
      final orderDetails = od.orderDetailsModel.orderDetails!;
      final mileStones = od.orderDetailsModel.orderMileStones!;
      return Column(
        children: mileStones
            .map((e) => Column(
                  children: [
                    OrderDetailsMilestoneCard(
                      milestoneId: e.id,
                      title: e.title,
                      milestoneStatus: e.status,
                      price: e.price,
                      paymentStatus: orderDetails.paymentStatus == "1"
                          ? LocalKeys.funded
                          : null,
                      approvedDate: e.deadline,
                      description: e.description,
                      totalRevision: e.revision,
                      remainingRevision: e.revisionLeft,
                    ),
                    16.toHeight,
                  ],
                ))
            .toList(),
      );
    });
  }
}
