import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/wallet_history_service.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/view_models/wallet_view_model/wallet_view_model.dart';

import 'components/remaining_balance.dart';
import 'components/wallet_history.dart';
import 'components/wallet_history_tile.dart';
import 'components/wallet_view_skeleton.dart';

class WalletView extends StatelessWidget {
  static const routeName = 'wallet_view';
  const WalletView({super.key});
  @override
  Widget build(BuildContext context) {
    final wvm = WalletViewModel.instance;
    wvm.scrollController.addListener(() {
      wvm.tryToLoadMore(context);
    });
    final whProvider =
        Provider.of<WalletHistoryService>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationPopIcon(),
          title: Text(LocalKeys.wallet),
        ),
        body: CustomRefreshIndicator(
          onRefresh: () async {
            await whProvider.fetchWalletHistory();
          },
          child: CustomFutureWidget(
            function: whProvider.shouldAutoFetch
                ? whProvider.fetchWalletHistory()
                : null,
            shimmer: const WalletViewSkeleton(),
            child:
                Consumer<WalletHistoryService>(builder: (context, wh, child) {
              return Scrollbar(
                controller: wvm.scrollController,
                child: ListView.separated(
                    controller: wvm.scrollController,
                    padding: const EdgeInsets.all(20),
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      debugPrint((wh.walletHistory.histories?.data).toString());
                      switch (index) {
                        case 0:
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RemainingBalance(
                                amount: wh.walletHistory.walletBalance ?? 0,
                              ),
                              20.toHeight,
                              const WalletHistory(),
                              2.toHeight,
                              if (wh.walletHistory.histories?.data?.isEmpty ??
                                  true)
                                Container(
                                  width: double.infinity,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  decoration: BoxDecoration(
                                      color: context.dProvider.whiteColor,
                                      borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(8),
                                          bottomRight: Radius.circular(8))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LottieBuilder.asset(
                                        "assets/animations/empty_list.json",
                                        width: context.width / 1.7,
                                        height: context.width / 1.7,
                                        fit: BoxFit.cover,
                                        repeat: false,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            LocalKeys.noHistoryFound,
                                            style: context.titleSmall
                                                ?.copyWith(
                                                    color: context
                                                        .dProvider.black5)
                                                .bold6,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                            ],
                          );
                        default:
                          if (wh.nextPage != null &&
                              (wh.walletHistory.histories!.data!.length + 1) ==
                                  index) {
                            return const CustomPreloader();
                          }
                          final hItem =
                              wh.walletHistory.histories!.data![index - 1];
                          return WalletHistoryTile(
                              amount: (hItem.amount ?? 0).toStringAsFixed(2),
                              pMethod: hItem.paymentGateway ?? "",
                              pStatus: hItem.paymentStatus.isEmpty
                                  ? LocalKeys.cancel
                                  : hItem.paymentStatus,
                              cDate: hItem.createdAt ?? DateTime.now());
                      }
                    },
                    separatorBuilder: (context, index) => 0.toHeight,
                    itemCount: (wh.walletHistory.histories?.data ?? []).length +
                        (wh.nextPage != null && !wh.nexLoadingFailed ? 2 : 1)),
              );
            }),
          ),
        ));
  }
}
