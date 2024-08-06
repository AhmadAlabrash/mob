import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/order_details_service.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/view_models/my_order_details_view_model/my_order_details_view_model.dart';
import 'package:xilancer/views/my_order_details_view/components/order_details_tabs.dart';
import 'package:xilancer/views/my_order_details_view/components/order_details_titles.dart';
import 'package:xilancer/views/my_orders_view/components/my_order_card_infos.dart';

import 'components/my_order_details_skeleton.dart';

class MyOrderDetailsView extends StatelessWidget {
  static const routeName = 'my_order_details_view';
  const MyOrderDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    MyOrderDetailsViewModel.dispose;
    final odProvider = Provider.of<OrderDetailsService>(context, listen: false);
    final orderId = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationPopIcon(),
          title: Text(LocalKeys.myOrder),
        ),
        body: CustomRefreshIndicator(
          onRefresh: () async {
            await odProvider.fetchOrderDetails(orderId: orderId);
          },
          child: CustomFutureWidget(
              function: odProvider.shouldAutoFetch(orderId)
                  ? odProvider.fetchOrderDetails(orderId: orderId)
                  : null,
              shimmer: const MyOrderSkeleton(),
              child:
                  Consumer<OrderDetailsService>(builder: (context, od, child) {
                final orderDetails = od.orderDetailsModel.orderDetails!;
                final user = orderDetails.freelancer;
                return ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.dProvider.whiteColor,
                      ),
                      child: MyOrderCardInfos(
                        id: orderId,
                        customerName:
                            "${user?.firstName ?? ""} ${user?.lastName ?? ""}",
                        budget: orderDetails.price,
                        orderType: orderDetails.isCustom
                            ? LocalKeys.customOrder
                            : null,
                        orderStatus: orderDetails.status.toString(),
                        title: orderDetails.project?.title ??
                            orderDetails.job?.title ??
                            LocalKeys.customOrder,
                        jobStatus: orderDetails.isProjectJob,
                        deadline: orderDetails.deliveryTime,
                        rating: orderDetails.rating?.isEmpty ?? true
                            ? null
                            : orderDetails.rating!.first.rating,
                        customerImage:
                            orderDetails.freelancer?.image?.profileImage ?? "",
                        paymentStatus: orderDetails.paymentStatus,
                        fromDetails: true,
                        createdAt: orderDetails.createdAt,
                      ),
                    ),
                    20.toHeight,
                    const OrderDetailsTitles(orderHaveMilestone: true),
                    12.toHeight,
                    const OrderDetailsTabs(orderHaveMilestone: true),
                    20.toHeight,
                  ],
                );
              })),
        ));
  }
}
