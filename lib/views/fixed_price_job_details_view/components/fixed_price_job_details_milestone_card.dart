import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class FixedPriceJobDetailsMilestoneCard extends StatelessWidget {
  final title;
  final milestoneStatus;
  final price;
  final paymentStatus;
  final approvedDate;
  final dueDate;
  final description;

  const FixedPriceJobDetailsMilestoneCard({
    super.key,
    this.title,
    this.milestoneStatus,
    this.price,
    this.paymentStatus,
    this.approvedDate,
    this.dueDate,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.titleMedium?.bold6,
                  ),
                  8.toHeight,
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: milestoneStatus == 2
                          ? context.dProvider.greenColor.withOpacity(.05)
                          : context.dProvider.primary05,
                    ),
                    child: Text(
                      milestoneStatus == 2
                          ? LocalKeys.milestoneApproved
                          : LocalKeys.milestoneFunded,
                      style: context.titleSmall?.copyWith(
                          color: milestoneStatus == 2
                              ? context.dProvider.greenColor
                              : context.dProvider.primaryColor),
                    ),
                  ),
                ],
              ),
              PopupMenuButton(
                itemBuilder: (context) =>
                    [const PopupMenuItem(child: Text("Item 1"))],
              )
            ],
          ),
          8.toHeight,
          Wrap(
            children: [
              Text(
                "$price".cur,
                style: context.titleMedium?.bold6.copyWith(
                  color: milestoneStatus == 2
                      ? context.dProvider.greenColor
                      : context.dProvider.primaryColor,
                ),
              ),
              8.toWidth,
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: milestoneStatus == 2
                          ? context.dProvider.greenColor
                          : context.dProvider.primaryColor,
                    )),
                child: Text(
                  milestoneStatus == 2 ? LocalKeys.complete : LocalKeys.active,
                  style: context.titleSmall?.copyWith(
                      color: milestoneStatus == 2
                          ? context.dProvider.greenColor
                          : context.dProvider.primaryColor),
                ),
              ),
              8.toWidth,
              Text(
                "${milestoneStatus == 2 ? LocalKeys.approvedOn : LocalKeys.due} ${DateFormat("dd MMM").format(approvedDate ?? dueDate)}",
                style: context.titleSmall
                    ?.copyWith(color: context.dProvider.black5),
              ),
            ],
          ),
          8.toHeight,
          if (description != null)
            Text(
              description,
              style:
                  context.titleSmall?.copyWith(color: context.dProvider.black5),
            ),
          if (milestoneStatus != 2) 8.toHeight,
          if (milestoneStatus != 2)
            ElevatedButton(onPressed: () {}, child: Text(LocalKeys.submitWork)),
        ],
      ),
    );
  }
}
