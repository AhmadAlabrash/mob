import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/view_models/my_order_details_view_model/my_order_details_view_model.dart';
import 'package:xilancer/views/my_order_details_view/my_order_details_view.dart';

import 'my_order_card_infos.dart';

class MyOrderCard extends StatelessWidget {
  final id;
  final orderType;
  final title;
  final jobStatus;
  final orderStatus;
  final customerName;
  final paymentStatus;
  final rating;
  final deadline;
  final createdAt;
  final String customerImage;
  final num budget;

  const MyOrderCard({
    super.key,
    required this.id,
    required this.orderType,
    required this.title,
    required this.jobStatus,
    required this.customerImage,
    required this.budget,
    this.paymentStatus,
    this.orderStatus,
    this.customerName,
    this.rating,
    this.deadline,
    this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    final modm = MyOrderDetailsViewModel.instance;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyOrderCardInfos(
            id: id,
            customerName: customerName,
            budget: budget,
            orderType: orderType,
            orderStatus: orderStatus,
            title: title,
            jobStatus: jobStatus,
            deadline: deadline,
            rating: rating,
            customerImage: customerImage,
            paymentStatus: paymentStatus,
            createdAt: createdAt,
          ),
          8.toHeight,
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                    onPressed: () {
                      context.toNamed(MyOrderDetailsView.routeName,
                          arguments: id);
                    },
                    child: Text(LocalKeys.viewOrder))
                .hp20,
          ),
        ],
      ),
    );
  }
}
