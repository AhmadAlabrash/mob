import 'package:flutter/material.dart';
import '/helper/extension/context_extension.dart';
import '/helper/local_keys.g.dart';
import '/views/wallet_history_view/wallet_history_view.dart';

class RecentHistoryLabel extends StatelessWidget {
  const RecentHistoryLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      color: context.dProvider.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            LocalKeys.recentHistory,
            style: context.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
          ElevatedButton(
              onPressed: () {
                context.toNamed(WalletHistoryView.routeName);
              },
              child: Text(LocalKeys.exploreAll))
        ],
      ),
    );
  }
}
