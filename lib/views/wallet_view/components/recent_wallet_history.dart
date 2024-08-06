import 'package:flutter/material.dart';
import 'wallet_history_tile0.dart';

class RecentWalletHistory extends StatelessWidget {
  const RecentWalletHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...Iterable.generate(6).map((e) => Column(
              children: [
                WalletHistoryTile(e % 3 != 0),
              ],
            ))
      ],
    );
  }
}
