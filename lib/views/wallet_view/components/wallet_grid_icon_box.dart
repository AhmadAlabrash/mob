import 'package:flutter/material.dart';

import '/helper/extension/context_extension.dart';
import '/helper/extension/string_extension.dart';
import '../../../utils/components/empty_spacer_helper.dart';

class WalletGridIconBox extends StatelessWidget {
  const WalletGridIconBox(
      {super.key,
      required this.gridColor,
      required this.title,
      required this.svgIcon,
      this.amount,
      this.value});

  final Color gridColor;
  final title;
  final String? amount;
  final value;
  final String svgIcon;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        width: (context.width - (48 + 16)) / 2,
        height: 162,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: gridColor.withOpacity(0.1)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 32,
            width: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: context.dProvider.whiteColor),
            child: svgIcon.toSVGSized(24, color: gridColor),
          ),
          EmptySpaceHelper.emptyHeight(52),
          Text(
            amount != null ? amount!.cur : value.toString(),
            style: context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          EmptySpaceHelper.emptyHeight(6),
          Text(title,
              style: context.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: context.dProvider.black5,
              )),
        ]),
      ),
    );
  }
}
