import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/view_models/place_order_view_model/milestone_model.dart';

import '../../../helper/local_keys.g.dart';
import '../../../view_models/place_order_view_model/place_order_view_model.dart';
import 'milestone_sheet.dart';

class MilestoneCard extends StatelessWidget {
  final Milestone milestone;
  const MilestoneCard({super.key, required this.milestone});

  @override
  Widget build(BuildContext context) {
    final pom = PlaceOrderViewViewModel.instance;
    return Dismissible(
      key: Key(milestone.id.toString()),
      onDismissed: (direction) {
        pom.removeMilestone(milestone.id);
      },
      child: GestureDetector(
        onTapUp: (details) {
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
                details.globalPosition.dx,
                details.globalPosition.dy,
                context.width - details.globalPosition.dx,
                context.height - details.globalPosition.dy),
            items: [
              PopupMenuItem(
                  onTap: () {
                    pom.resetMilestoneSheet(
                      name: milestone.name,
                      desc: milestone.description,
                      price: milestone.price,
                      revision: milestone.price,
                      dTime: milestone.dTime,
                    );
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isDismissible: false,
                      isScrollControlled: true,
                      builder: (context) => MilestoneSheet(
                        editing: true,
                        id: milestone.id,
                      ),
                    );
                  },
                  child: Text(
                    LocalKeys.edit,
                  )),
              PopupMenuItem(
                  onTap: () {
                    pom.removeMilestone(milestone.id);
                  },
                  child: Text(
                    LocalKeys.remove,
                  )),
            ],
          );
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: context.dProvider.whiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: context.dProvider.black8,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      milestone.name,
                      style: context.titleMedium?.bold6,
                    ),
                  ),
                ],
              ),
              12.toHeight,
              Wrap(
                runSpacing: 8,
                spacing: 8,
                children: [
                  Text(
                    milestone.price.toStringAsFixed(2).cur,
                    style: context.titleSmall?.bold6.copyWith(
                      color: context.dProvider.primaryColor,
                    ),
                  ),
                  RichText(
                    maxLines: 2,
                    text: TextSpan(
                        text: "${LocalKeys.revision}: ",
                        style: context.titleSmall
                            ?.copyWith(color: context.dProvider.black5),
                        children: [
                          TextSpan(
                              text: milestone.revision.round().toString(),
                              style: context.titleSmall
                                  ?.copyWith(color: context.dProvider.black5)
                                  .bold6)
                        ]),
                  ),
                  RichText(
                    maxLines: 2,
                    text: TextSpan(
                        text: "${LocalKeys.deliveryTime}: ",
                        style: context.titleSmall
                            ?.copyWith(color: context.dProvider.black5),
                        children: [
                          TextSpan(
                              text: milestone.dTime,
                              style: context.titleSmall
                                  ?.copyWith(color: context.dProvider.black5)
                                  .bold6)
                        ]),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
