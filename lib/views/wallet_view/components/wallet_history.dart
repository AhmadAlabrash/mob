import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class WalletHistory extends StatelessWidget {
  const WalletHistory({super.key});

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
          Text(
            LocalKeys.walletHistory,
            style: context.titleMedium?.bold6,
          ),
        ],
      ),
    );
  }
}
