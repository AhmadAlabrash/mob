import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

import '../../../helper/local_keys.g.dart';

class WalletHistoryTile extends StatelessWidget {
  final String amount;
  final String pStatus;
  final String pMethod;
  final DateTime? cDate;
  const WalletHistoryTile({
    super.key,
    required this.amount,
    required this.pStatus,
    required this.pMethod,
    this.cDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: context.dProvider.whiteColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                  text: TextSpan(
                      text: amount.cur,
                      style: context.titleLarge?.bold6,
                      children: const [])),
            ],
          ),
          8.toHeight,
          RichText(
              text: TextSpan(
                  text: "${LocalKeys.paymentStatus.capitalize}: ",
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.black5),
                  children: [
                TextSpan(
                    text: pStatus.capitalize.tr(),
                    style: context.titleSmall?.copyWith(
                        color: pStatus == LocalKeys.cancel
                            ? context.dProvider.warningColor
                            : pStatus == "cancel"
                                ? context.dProvider.yellowColor
                                : context.dProvider.greenColor)),
              ])),
          8.toHeight,
          RichText(
              text: TextSpan(
                  text:
                      "${LocalKeys.paymentMethods.replaceAll("s", "").capitalize}: ",
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.black5),
                  children: [
                TextSpan(
                    text: pMethod.replaceAll("_", " ").capitalize,
                    style: context.titleSmall
                        ?.copyWith(color: context.dProvider.primaryColor)),
              ])),
          8.toHeight,
          RichText(
              text: TextSpan(
                  text: DateFormat("MMM dd, yyyy", dProvider.languageSlug)
                      .format(cDate!),
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.black5),
                  children: const []))
        ],
      ),
    );
  }
}
