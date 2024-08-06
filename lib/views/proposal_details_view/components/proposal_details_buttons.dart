import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/view_models/fix_price_job_details_view_model/fix_price_job_details_view_model.dart';

import '../../../helper/svg_assets.dart';

class ProposalDetailsButtons extends StatelessWidget {
  final proposalId;
  final shortlisted;
  final hired;
  final rejected;
  final chatInfo;
  const ProposalDetailsButtons({
    super.key,
    this.proposalId,
    required this.hired,
    required this.rejected,
    required this.shortlisted,
    required this.chatInfo,
  });

  @override
  Widget build(BuildContext context) {
    final jdm = FixPriceJobDetailsViewModel.instance;
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.primaryColor,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                debugPrint(proposalId.toString());
                if (!rejected && !hired) {
                  jdm.tryAcceptingProposal(context, id: proposalId);
                } else {
                  jdm.tryAddingShortList(context,
                      id: proposalId, shortlisted: shortlisted);
                }
              },
              child: Text(
                !rejected && !hired
                    ? LocalKeys.accept
                    : (shortlisted
                        ? LocalKeys.removeFromShortlist
                        : LocalKeys.addToShortlist),
                textAlign: TextAlign.center,
                style: context.titleMedium?.bold6.copyWith(
                  color: context.dProvider.whiteColor,
                ),
              ),
            ),
          ),
          if (!rejected && !hired)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: VerticalDivider(
                color: context.dProvider.whiteColor.withOpacity(.20),
                thickness: 2,
              ),
            ),
          if (!rejected && !hired)
            PopupMenuButton(
              onSelected: (value) {
                final jdm = FixPriceJobDetailsViewModel.instance;
                debugPrint(proposalId.toString());
                switch (value) {
                  case "reject":
                    jdm.tryRejecting(context, id: proposalId);
                    break;
                  default:
                    jdm.tryAddingShortList(
                      context,
                      id: proposalId,
                      shortlisted: shortlisted,
                    );
                }
              },
              itemBuilder: (context) => [
                if (!rejected && !hired)
                  PopupMenuItem(
                    value: "reject",
                    child: Text(LocalKeys.reject),
                  ),
                PopupMenuItem(
                    value: "shortlist",
                    child: Text(shortlisted
                        ? LocalKeys.removeFromShortlist
                        : LocalKeys.addToShortlist)),
              ],
              iconColor: context.dProvider.whiteColor,
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
            )
        ],
      ),
    );
  }
}
