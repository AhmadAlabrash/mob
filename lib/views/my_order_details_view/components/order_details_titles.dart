import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/order_details_service.dart';
import 'package:xilancer/view_models/my_order_details_view_model/my_order_details_view_model.dart';

import '../../../helper/local_keys.g.dart';

class OrderDetailsTitles extends StatelessWidget {
  final orderHaveMilestone;
  const OrderDetailsTitles({super.key, this.orderHaveMilestone = false});

  @override
  Widget build(BuildContext context) {
    final modm = MyOrderDetailsViewModel.instance;
    return Consumer<OrderDetailsService>(builder: (context, od, child) {
      List titles = orderHaveMilestone
          ? [
              LocalKeys.description,
              if (od.orderDetailsModel.orderMileStones != null &&
                  od.orderDetailsModel.orderMileStones!.isNotEmpty)
                LocalKeys.milestones,
              LocalKeys.submittedWork,
            ]
          : [
              LocalKeys.description,
              LocalKeys.submittedWork,
            ];
      return ValueListenableBuilder(
        valueListenable: modm.selectedTitleIndex,
        builder: (context, value, child) => SizedBox(
          height: 40,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      modm.selectedTitleIndex.value = index;
                    },
                    child: Container(
                      width: (context.width - 48) / titles.length,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: value == index
                                      ? context.dProvider.primaryColor
                                      : context.dProvider.black5))),
                      child: Text(
                        titles[index],
                        textAlign: TextAlign.center,
                        style: context.titleSmall?.copyWith(
                            color: value == index
                                ? context.dProvider.primaryColor
                                : context.dProvider.black4),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => 4.toWidth,
              itemCount: titles.length),
        ),
      );
    });
  }
}
