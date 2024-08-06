import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/payment_gateway_service.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/utils/components/field_label.dart';
import 'package:xilancer/utils/components/field_with_label.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/views/payment_views/payment_gateways.dart';
import 'package:xilancer/utils/components/tac_pp.dart';
import 'package:xilancer/utils/components/warning_widget.dart';
import 'package:xilancer/view_models/place_order_view_model/place_order_view_model.dart';
import 'package:xilancer/views/place_order_view/components/milestones.dart';

import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/constant_helper.dart';
import '../../view_models/onboarding_view_model/onboarding_view_model.dart';
import '../../view_models/place_order_view_model/payment_methode_navigator_helper.dart';
import '../my_order_details_view/my_order_details_view.dart';
import '../onboarding_view/onboarding_view.dart';
import '../proccess_status_view/place_order_status_view.dart';

class PlaceOrderView extends StatelessWidget {
  final projectId;
  final offerId;
  final jobId;
  final proposalId;
  const PlaceOrderView({
    super.key,
    this.projectId,
    this.offerId,
    this.jobId,
    this.proposalId,
  });

  @override
  Widget build(BuildContext context) {
    final pom = PlaceOrderViewViewModel.instance;
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.dProvider.whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WarningWidget(text: LocalKeys.orderWarning),
              16.toHeight,
              ValueListenableBuilder(
                valueListenable: pom.walletSelect,
                builder: (context, ws, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        value: ws,
                        onChanged: (value) {
                          pom.walletSelect.value = !ws;
                        },
                        title: Text(LocalKeys.useWalletBallance),
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      if (!ws) ...[
                        FieldLabel(label: LocalKeys.selectAPaymentMethod),
                        PaymentGateways(
                          gatewayNotifier: pom.selectedGateway,
                          attachmentNotifier: pom.selectedAttachment,
                          cardController: pom.aCardController,
                          secretCodeController: pom.authCodeController,
                          zUsernameController: pom.zUsernameController,
                          expireDateNotifier: pom.authNetExpireDate,
                          usernameController: TextEditingController(),
                        ),
                        16.toHeight,
                      ],
                    ],
                  );
                },
              ),
              FieldWithLabel(
                label: LocalKeys.description,
                hintText: LocalKeys.enterDescription,
                controller: pom.descriptionController,
                minLines: 3,
                maxLines: 10,
              ),
              if (projectId != null)
                ValueListenableBuilder(
                  valueListenable: pom.addMilestones,
                  builder: (context, ms, child) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CheckboxListTile(
                          contentPadding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          value: ms,
                          onChanged: (value) {
                            pom.addMilestones.value = !ms;
                          },
                          title: Text(LocalKeys.paByMilestones),
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        Text(
                          LocalKeys.paByMilestonesDesc,
                          style: context.titleSmall
                              ?.copyWith(color: context.dProvider.black5),
                        ),
                        6.toHeight,
                        if (ms) const Milestones(),
                      ],
                    );
                  },
                ),
              ValueListenableBuilder(
                valueListenable: pom.isLoading,
                builder: (context, loading, child) {
                  return CustomButton(
                      onPressed: () {
                        pom.tryPlacingOrder(
                          context: context,
                          projectId: projectId,
                          jobId: jobId,
                          proposalId: proposalId,
                          offerId: offerId,
                        );
                      },
                      btText: LocalKeys.placeOrder,
                      isLoading: loading);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
