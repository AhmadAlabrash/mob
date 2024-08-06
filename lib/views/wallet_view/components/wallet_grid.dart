import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import '/helper/extension/context_extension.dart';
import '/helper/local_keys.g.dart';
import '/helper/svg_assets.dart';
import '/views/wallet_view/components/wallet_grid_box.dart';

import 'wallet_grid_icon_box.dart';

class WalletGrid extends StatelessWidget {
  const WalletGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: context.dProvider.whiteColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: WalletGridIconBox(
                gridColor: context.dProvider.primaryColor,
                title: LocalKeys.totalWithdraw,
                amount: "45621",
                svgIcon: SvgAssets.wallet),
          ),
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                WalletGridBox(
                    gridColor: context.dProvider.primary05,
                    title: LocalKeys.pendingWithdraw,
                    amount: '451'),
                16.toHeight,
                WalletGridBox(
                    gridColor: context.dProvider.primary05,
                    title: LocalKeys.todayWithdraw,
                    amount: '451'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
