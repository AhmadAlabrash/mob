import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/image_assets.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/models/notification_list_model.dart';

import 'notification_list_tile_icon.dart';

class NotificationListTile extends StatelessWidget {
  final String title;
  final Type? type;
  final DateTime date;
  final bool isRead;
  final dynamic id;
  final dynamic identity;
  const NotificationListTile(
      {super.key,
      required this.title,
      required this.date,
      required this.type,
      required this.isRead,
      this.id,
      this.identity});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: context.dProvider.whiteColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: isRead
                  ? context.dProvider.primary05
                  : context.dProvider.black9,
              child: SvgAssets.notification.toSVGSized(
                20,
                color: isRead ? context.dProvider.primaryColor : null,
              ),
            ),
          ),
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
              flex: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    style: context.titleMedium?.bold6.copyWith(
                        color: isRead ? context.dProvider.primaryColor : null),
                  ),
                  8.toHeight,
                  Text(
                    formatDateTime(date),
                    style: context.titleSmall?.copyWith(
                        color: isRead
                            ? context.dProvider.primary60
                            : context.dProvider.black5),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

String formatDateTime(DateTime date) {
  DateTime now = DateTime.now();

  if (date.year == now.year && date.month == now.month && date.day == now.day) {
    return '${LocalKeys.todayAt} ${DateFormat("hh:mm a", dProvider.languageSlug).format(date)}';
  } else if (date.difference(now).inDays.abs() < 7) {
    return '${DateFormat("EEEE", dProvider.languageSlug).format(date)} ${LocalKeys.at} ${DateFormat("hh:mm a", dProvider.languageSlug).format(date)}';
  } else {
    return '${DateFormat("MMMM", dProvider.languageSlug).format(date)} ${date.day}, ${date.year}';
  }
}
