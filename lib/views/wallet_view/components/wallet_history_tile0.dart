import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/helper/extension/context_extension.dart';
import '/helper/extension/string_extension.dart';
import '/utils/components/empty_spacer_helper.dart';

import '../../../helper/local_keys.g.dart';

class WalletHistoryTile extends StatelessWidget {
  final bool isDeposit;
  final bool showDivider;
  const WalletHistoryTile(this.isDeposit, {this.showDivider = true, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (showDivider)
          Container(
            color: context.dProvider.whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: context.dProvider.black9,
              thickness: 2,
              height: 2,
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: context.dProvider.whiteColor,
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "1000.00".cur,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: context.dProvider.black2),
                      ),
                      EmptySpaceHelper.emptyHeight(4),
                      RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: LocalKeys.paymentMethods,
                            style: context.titleMedium?.copyWith(
                                fontSize: 14, color: context.dProvider.black2),
                            children: [
                              TextSpan(
                                text: ": #${612}",
                                style: context.titleMedium
                                    ?.copyWith(
                                        fontSize: 14,
                                        color: context.dProvider.black2)
                                    .bold6,
                              ),
                            ]),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: isDeposit
                                  ? context.dProvider.greenColor.withOpacity(.1)
                                  : context.dProvider.primary10,
                            ),
                            child: Text(
                              isDeposit ? "Deposit" : LocalKeys.withdraw,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.titleMedium
                                  ?.copyWith(
                                      color: isDeposit
                                          ? context.dProvider.greenColor
                                          : context.dProvider.primaryColor)
                                  .bold6,
                            ),
                          ),
                        ],
                      ),
                      EmptySpaceHelper.emptyHeight(8),
                      Text(
                        DateFormat("d MMM yyyy HH:mm a").format(DateTime.now()),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.titleMedium?.copyWith(
                            fontSize: 14, color: context.dProvider.black2),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
