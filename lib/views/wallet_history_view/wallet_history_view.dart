import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import '/helper/local_keys.g.dart';
import '/utils/components/custom_refresh_indicator.dart';
import '/utils/components/navigation_pop_icon.dart';
import '/view_models/wallet_history_view_model/wallet_history_scroll_model.dart';
import '../wallet_view/components/wallet_history_tile0.dart';

class WalletHistoryView extends StatelessWidget {
  static const routeName = "wallet_history_view";
  const WalletHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final scroll = WalletHistoryScrollModel.instance;
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
        title: Text(LocalKeys.paymentHistory),
      ),
      body: Scrollbar(
        controller: scroll.scrollController,
        child: CustomRefreshIndicator(
            onRefresh: () {
              return Future.value();
            },
            child: ListView.separated(
                controller: scroll.scrollController,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemBuilder: (context, index) {
                  switch (index) {
                    default:
                      return WalletHistoryTile(
                        index - 1 % 3 != 0,
                        showDivider: false,
                      );
                  }
                },
                separatorBuilder: (context, index) => 2.toHeight,
                itemCount: 20 + 2)),
      ),
    );
  }
}
