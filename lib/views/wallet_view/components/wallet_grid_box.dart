import 'package:flutter/material.dart';

import '/helper/extension/context_extension.dart';
import '/helper/extension/string_extension.dart';
import '../../../utils/components/empty_spacer_helper.dart';
import 'wallet_grid_box_painter.dart';

class WalletGridBox extends StatelessWidget {
  const WalletGridBox({
    super.key,
    required this.gridColor,
    required this.title,
    required this.amount,
  });

  final Color gridColor;
  final title;
  final String? amount;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: WalletGridBoxPainter(color: gridColor.withOpacity(0.2)),
      child: Container(
        width: (context.width - (48 + 16)) / 2,
        height: 78,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: gridColor.withOpacity(0.1)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            amount!.cur,
            style: context.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          EmptySpaceHelper.emptyHeight(6),
          Text(title,
              style: context.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: context.dProvider.black5,
              )),
        ]),
      ),
    );
  }
}
