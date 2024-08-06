import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class ActivityInfo extends StatelessWidget {
  final title;
  final prefix;
  final date;
  final isLast;

  const ActivityInfo({
    super.key,
    this.title,
    this.prefix,
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
                    text: "$prefix ",
                    style: context.titleMedium,
                    children: [
                  TextSpan(text: title, style: context.titleMedium?.bold6)
                ])),
            8.toHeight,
            Text(
              DateFormat("hh:mm a, MMM MM, yyyy")
                  .format(date ?? DateTime.now()),
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
