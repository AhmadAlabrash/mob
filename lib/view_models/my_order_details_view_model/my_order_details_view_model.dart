import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/services/order_details_service.dart';
import 'package:xilancer/utils/components/alerts.dart';

import '../../helper/local_keys.g.dart';

class MyOrderDetailsViewModel {
  ValueNotifier<int> selectedTitleIndex = ValueNotifier(0);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  final GlobalKey<FormState> revisionFormKey = GlobalKey();

  TextEditingController revisionDescriptionController = TextEditingController();

  MyOrderDetailsViewModel._init();
  static MyOrderDetailsViewModel? _instance;
  static MyOrderDetailsViewModel get instance {
    _instance ??= MyOrderDetailsViewModel._init();
    return _instance!;
  }

  static bool get dispose {
    _instance = null;
    return true;
  }

  void tryCancelOrder(BuildContext context) {
    Alerts().confirmationAlert(
        context: context,
        title: LocalKeys.cancelOrderQ,
        description: LocalKeys.areYouSureToCancel,
        buttonText: LocalKeys.cancel,
        onConfirm: () async {
          context.popTrue;
        });
  }

  void tryDeclineOrder(BuildContext context) {
    Alerts().confirmationAlert(
        context: context,
        title: LocalKeys.declineOrderQ,
        description: LocalKeys.orderDeclineWarning,
        buttonText: LocalKeys.decline,
        onConfirm: () async {
          context.popTrue;
        });
  }

  void tryAcceptOrder(BuildContext context, {orderId, milestoneId}) {
    Alerts().confirmationAlert(
        context: context,
        title: LocalKeys.acceptOrderQ,
        description: LocalKeys.orderAcceptWarning,
        buttonText: LocalKeys.accept,
        buttonColor: context.dProvider.primaryColor,
        onConfirm: () async {
          await Provider.of<OrderDetailsService>(context, listen: false)
              .tryAcceptingWork(orderId: orderId, milestoneId: milestoneId);
          context.popTrue;
        });
  }

  tryRequestingRevision(BuildContext context,
      {orderWorkId, milestoneId, orderId}) async {
    isLoading.value = true;
    await Provider.of<OrderDetailsService>(context, listen: false)
        .tryRequestingRevision(
      orderWorkId: orderWorkId,
      milestoneId: milestoneId,
      orderId: orderId,
      description: revisionDescriptionController.text,
    );
    isLoading.value = false;
    context.pop;
  }
}
