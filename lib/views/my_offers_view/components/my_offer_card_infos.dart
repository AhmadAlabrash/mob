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
import 'package:xilancer/app_static_values.dart' as apps;

import '../../chat_list_view/components/chat_tile_avatar.dart';

class MyOfferCardInfos extends StatelessWidget {
  const MyOfferCardInfos({
    super.key,
    required this.id,
    required this.offerStatus,
    required this.budget,
    this.customerName,
    this.deadline,
    this.fromDetails = false,
    this.paymentStatus,
    this.createdAt,
    required this.customerImage,
  });

  final id;
  final offerStatus;
  final deadline;
  final budget;
  final customerName;
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
        8.toHeight,
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            if (offerStatus != null)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context
                      .dProvider.statusColors[int.tryParse(offerStatus) ?? 0]
                      .withOpacity(.10),
                ),
                child: Text(
                  apps.offerStatus[int.tryParse(offerStatus) ?? 0].capitalize,
                  style: context.titleSmall?.copyWith(
                    color: context
                        .dProvider.statusColors[int.tryParse(offerStatus) ?? 0],
                  ),
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: context.dProvider.yellowColor.withOpacity(.05),
              ),
              child: Text(
                LocalKeys.customOffer,
                style: context.titleSmall
                    ?.copyWith(color: context.dProvider.yellowColor),
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
                  LocalKeys.offerPrice,
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
                  deadline is String ? deadline : LocalKeys.byMilestone,
                  style: context.titleSmall?.bold6,
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
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                LocalKeys.customer,
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
