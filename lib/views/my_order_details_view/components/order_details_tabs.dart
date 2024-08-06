import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/order_details_service.dart';
import 'package:xilancer/view_models/my_order_details_view_model/my_order_details_view_model.dart';
import 'package:xilancer/views/my_order_details_view/components/order_details_description.dart';
import 'package:xilancer/views/my_order_details_view/components/order_details_milestons.dart';
import 'package:xilancer/views/my_order_details_view/components/order_details_work_submit.dart';

class OrderDetailsTabs extends StatelessWidget {
  final orderHaveMilestone;
  const OrderDetailsTabs({super.key, this.orderHaveMilestone = false});

  @override
  Widget build(BuildContext context) {
    final modm = MyOrderDetailsViewModel.instance;
    return Consumer<OrderDetailsService>(builder: (context, od, child) {
      final widgets = [
        OrderDetailsDescription(
          description: (od.orderDetailsModel.orderDetails?.description),
        ),
        if (od.orderDetailsModel.orderMileStones != null &&
            od.orderDetailsModel.orderMileStones!.isNotEmpty)
          const OrderDetailsMilestone(),
        const OrderDetailsWorkSubmit(orderHaveMilestone: true),
      ];
      return ValueListenableBuilder(
        valueListenable: modm.selectedTitleIndex,
        builder: (context, value, child) => widgets[value],
      );
    });
  }
}
