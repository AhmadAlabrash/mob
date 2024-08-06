import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeAgo;
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/image_assets.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/views/my_order_details_view/components/earning_tiles.dart';
import 'package:xilancer/views/my_orders_view/components/my_order_id.dart';

import '../../chat_list_view/components/chat_tile_avatar.dart';

class MyOrderCardInfos extends StatelessWidget {
  const MyOrderCardInfos({
    super.key,
    required this.id,
    required this.orderType,
    required this.title,
    required this.jobStatus,
    required this.budget,
    this.orderStatus,
    this.customerName,
    this.rating,
    this.deadline,
    this.fromDetails = false,
    this.paymentStatus,
    this.createdAt,
    required this.customerImage,
  });

  final id;
  final orderType;
  final title;
  final jobStatus;
  final deadline;
  final budget;
  final orderStatus;
  final customerName;
  final rating;
  final fromDetails;
  final paymentStatus;
  final createdAt;
  final String customerImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyOrderId(
          id: "#$id",
        ).hp20,
        if (title != null) 8.toHeight,
        if (title != null)
          Text(
            title,
            style: context.titleMedium?.bold6,
          ).hp20,
        8.toHeight,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            if (jobStatus != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.dProvider.black9,
                ),
                child: Text(
                  jobStatus.toString().capitalize,
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.black4),
                ),
              ),
            if (orderType != null)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.dProvider.greenColor.withOpacity(.05),
                ),
                child: Text(
                  orderType,
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.greenColor),
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.dProvider.primary05,
              ),
              child: Text(
                orderStatus.toString().getStatus,
                style: context.titleSmall
                    ?.copyWith(color: context.dProvider.primaryColor),
              ),
            ),
            if (rating != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.dProvider.yellowColor.withOpacity(0.05),
                ),
                child: FittedBox(
                  child: Row(
                    children: [
                      Icon(Icons.star_rounded,
                          size: 16, color: context.dProvider.yellowColor),
                      Text(
                        "$rating",
                        style: context.titleSmall
                            ?.copyWith(color: context.dProvider.yellowColor),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ).hp20,
        if (createdAt != null) ...[
          8.toHeight,
          Text(
            timeAgo.format(createdAt,
                locale: context.dProvider.languageSlug.substring(0, 2)),
            style:
                context.titleSmall?.copyWith(color: context.dProvider.black5),
          ).hp20,
        ],
        Divider(
          color: context.dProvider.black8,
          thickness: 2,
          height: 24,
        ),
        SizedBox(
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  LocalKeys.orderBudget,
                  style: context.titleSmall?.black5,
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Text(
                      "$budget".cur,
                      style: context.titleSmall?.bold6,
                    ),
                    4.toWidth,
                    if (paymentStatus == "complete")
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: context.dProvider.primary05,
                        ),
                        child: Text(
                          LocalKeys.orderFunded,
                          style: context.titleSmall
                              ?.copyWith(color: context.dProvider.primaryColor),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ).hp20,
        ),
        Divider(
          color: context.dProvider.black8,
          thickness: 2,
          height: 24,
        ),
        if (deadline != null)
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    LocalKeys.deliveryTime,
                    style: context.titleSmall?.black5,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    deadline is String
                        ? deadline
                        : DateFormat("MMM yyyy").format(deadline),
                    style: context.titleSmall?.bold6,
                  ),
                ),
              ],
            ).hp20,
          ),
        if (deadline != null)
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 24,
          ),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                LocalKeys.freelancer,
                style: context.titleSmall?.black5,
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ChatTileAvatar(
                    placeHolderImage: ImageAssets.avatar,
                    name: "",
                    size: 32.0,
                    imageUrl: customerImage,
                  ),
                  12.toWidth,
                  Text(
                    customerName,
                    style: context.titleSmall?.bold6,
                  ),
                  2.toHeight
                ],
              ),
            ),
          ],
        ).hp20,
        if (fromDetails) const EarningTiles(),
      ],
    );
  }
}
