import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class OrderDetailsClientAbout extends StatelessWidget {
  final String name;
  final String email;
  const OrderDetailsClientAbout(
      {super.key, required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalKeys.aboutClient,
            style: context.titleMedium?.bold6,
          ).hp20,
          20.toHeight,
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 16,
          ),
          infos(
            context,
            LocalKeys.name,
            name,
          ),
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 16,
          ),
          infos(context, LocalKeys.email, email),
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 16,
          ),
          infos(context, LocalKeys.hireRate, "87%"),
        ],
      ),
    );
  }

  infos(BuildContext context, title, desc) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: context.titleSmall?.black5,
          )),
          Expanded(
              child: Text(
            desc,
            textAlign: TextAlign.end,
            style: context.titleSmall?.bold6,
          ))
        ],
      ).hp20,
    );
  }
}
