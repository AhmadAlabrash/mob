import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/services/offer_details_service.dart';
import 'package:xilancer/views/place_order_view/components/milestone_card.dart';

import '../../../helper/local_keys.g.dart';
import '../../my_order_details_view/components/order_details_milestone_card.dart';

class OfferMilestones extends StatelessWidget {
  const OfferMilestones({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OfferDetailsService>(builder: (context, od, child) {
      return od.offerDetailsModel.offerDetails?.milestones?.isEmpty ?? true
          ? const SizedBox()
          : Column(
              children: [
                20.toHeight,
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.dProvider.whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocalKeys.milestone,
                            style: context.titleMedium?.bold6,
                          ).hp20,
                        ],
                      ),
                      Divider(
                        color: context.dProvider.black8,
                        thickness: 2,
                        height: 24,
                      ),
                      ...od.offerDetailsModel.offerDetails!.milestones!
                          .map((e) {
                        bool isLast = false;
                        try {
                          isLast = od
                                  .offerDetailsModel.offerDetails!.milestones!
                                  .indexWhere((element) =>
                                      element.id.toString() ==
                                      e.id.toString()) ==
                              (od.offerDetailsModel.offerDetails!.milestones!
                                      .length -
                                  1);
                        } catch (e) {}
                        return Column(
                          children: [
                            OrderDetailsMilestoneCard(
                              title: e.title,
                              milestoneStatus: e.status,
                              description: e.description,
                              price: e.price,
                              totalRevision: e.revision,
                              approvedDate: e.deadline,
                              showButton: false,
                            ),
                            if (!isLast)
                              Divider(
                                color: context.dProvider.black8,
                                thickness: 2,
                                height: 24,
                              ),
                          ],
                        );
                      }).toList()
                    ],
                  ),
                ),
              ],
            );
    });
  }
}
