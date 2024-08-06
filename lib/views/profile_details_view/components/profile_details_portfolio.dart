import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/profile_details_service.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_portfolio_card.dart';

import '../../../view_models/profile_details_view_model/profile_details_view_model.dart';

class ProfileDetailsPortfolio extends StatelessWidget {
  final ProfileDetailsService pd;
  const ProfileDetailsPortfolio({super.key, required this.pd});

  @override
  Widget build(BuildContext context) {
    final portFolios = pd.profileDetails.portfolios ?? [];
    final pf = pd.profileDetails.portfolioPath.toString();
    int index = 0;
    final pdm = ProfileDetailsViewModel.instance;
    return portFolios.isEmpty
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.dProvider.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocalKeys.portfolio,
                        style: context.titleMedium?.bold6),
                    ValueListenableBuilder(
                        valueListenable: pdm.viewAsClient,
                        builder: (context, value, child) => value
                            ? const SizedBox()
                            : GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  Icons.add_circle_outline_rounded,
                                  color: context.dProvider.black3,
                                )))
                  ],
                ).hp20,
                Divider(
                  color: context.dProvider.black8,
                  thickness: 2,
                  height: 36,
                ),
                ...portFolios
                    .map((e) => Column(
                          children: [
                            ProfileDetailsPortfolioCard(portFolio: e, path: pf),
                            if (++index != portFolios.length)
                              Divider(
                                color: context.dProvider.black8,
                                thickness: 2,
                                height: 36,
                              ).hp20
                          ],
                        ))
                    .toList(),
              ],
            ),
          );
  }
}
