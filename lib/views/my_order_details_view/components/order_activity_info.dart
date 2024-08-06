import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class OrderActivityInfo extends StatelessWidget {
  final title;
  final date;
  final isLast;

  const OrderActivityInfo({
    super.key,
    this.title,
    this.date,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
              right: context.dProvider.textDirectionRight ? 0 : 16,
              left: context.dProvider.textDirectionRight ? 16 : 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 5,
                backgroundColor: context.dProvider.primaryColor,
              ),
              2.toHeight,
              Container(
                  width: 2,
                  color: isLast ? null : context.dProvider.black8,
                  constraints:
                      isLast ? null : const BoxConstraints(minHeight: 70),
                  child: const VerticalDivider()),
              2.toHeight,
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: "${LocalKeys.youGotATip} ",
                    style: context.titleMedium,
                    children: [
                  TextSpan(
                      text: "Daniel Kleine", style: context.titleMedium?.bold6)
                ])),
            8.toHeight,
            Text(
              DateFormat("EEEE, hh:mm a").format(DateTime.now()),
              style: context.titleSmall?.copyWith(
                color: context.dProvider.black4,
              ),
            )
          ],
        )
      ],
    ).hp20;
  }
}
