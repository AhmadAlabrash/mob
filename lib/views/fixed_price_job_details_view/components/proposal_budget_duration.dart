import 'package:flutter/material.dart';

import '../../../helper/extension/context_extension.dart';
import '../../../helper/extension/string_extension.dart';
import '../../../helper/local_keys.g.dart';

class ProposalBudgetDuration extends StatelessWidget {
  const ProposalBudgetDuration({
    super.key,
    required this.offeredPrice,
    required this.estDuration,
  });

  final String offeredPrice;
  final estDuration;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: RichText(
              text: TextSpan(
                  text: "${LocalKeys.offered}: ",
                  style: context.titleMedium
                      ?.copyWith(color: context.dProvider.black5),
                  children: [
                TextSpan(
                    text: offeredPrice.cur,
                    style: context.titleSmall?.bold6
                        .copyWith(color: context.dProvider.primaryColor)),
              ])),
        ),
        Expanded(
            flex: 1,
            child: SizedBox(
              height: 24,
              child: VerticalDivider(
                  thickness: 2, color: context.dProvider.black8),
            )),
        Expanded(
          flex: 6,
          child: RichText(
              text: TextSpan(
                  text: "${LocalKeys.estDeliveryDuration}: ",
                  style: context.titleMedium
                      ?.copyWith(color: context.dProvider.black5),
                  children: [
                TextSpan(
                    text: estDuration,
                    style: context.titleSmall?.bold6
                        .copyWith(color: context.dProvider.primaryColor)),
              ])),
        ),
      ],
    );
  }
}
