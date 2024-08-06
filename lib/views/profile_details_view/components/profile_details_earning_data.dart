import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/services/profile_details_service.dart';
import 'package:xilancer/views/profile_details_view/components/profile_earning_tile.dart';

class ProfileDetailsEarningData extends StatelessWidget {
  final ProfileDetailsService pd;
  const ProfileDetailsEarningData({super.key, required this.pd});

  @override
  Widget build(BuildContext context) {
    final data = {
      LocalKeys.totalEarned: {
        "svg": SvgAssets.moneyReceive,
        "price": (pd.profileDetails.totalEarning?.totalEarning ?? 0),
        "value": (pd.profileDetails.totalEarning?.totalEarning ?? 0)
            .toStringAsFixed(0),
        "color": context.dProvider.primaryColor,
      },
      LocalKeys.projectCompleted: {
        "svg": SvgAssets.circleTick,
        "price": null,
        "value": pd.profileDetails.completeOrders?.length.toString() ?? "0",
        "color": context.dProvider.greenColor,
      },
      LocalKeys.activeOrder: {
        "svg": SvgAssets.timer,
        "price": null,
        "value": pd.profileDetails.activeOrderCount?.toString() ?? "0",
        "color": context.dProvider.yellowColor,
      },
    };
    int index = 0;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        children: data.keys
            .toList()
            .map((key) => Column(
                  children: [
                    ProfileEarningTile(
                        price: data[key]?["price"]
                            ?.toString()
                            .tryToParse
                            .toStringAsFixed(2),
                        value: data[key]!["value"],
                        subtitle: key,
                        svg: data[key]!["svg"] as String,
                        color: data[key]!["color"]),
                    if ((++index) != data.length)
                      Divider(
                        color: context.dProvider.black8,
                        thickness: 2,
                      ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
