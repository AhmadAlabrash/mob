import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';

import 'components/recent_history_label.dart';
import 'components/recent_wallet_history.dart';
import 'components/wallet_grid.dart';

class WalletABNView extends StatelessWidget {
  static const routeName = "wallet_view";
  const WalletABNView({super.key});

  @override
  Widget build(BuildContext context) {
    final walletWidgets = [
      const WalletGrid(),
      2.toHeight,
      const RecentHistoryLabel(),
      const RecentWalletHistory(),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
            color: context.dProvider.whiteColor,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8))),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
        title: Text(LocalKeys.wallet),
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              return walletWidgets[index];
            },
            itemCount: walletWidgets.length,
          ))
        ],
      ),
    );
  }

  delay() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
