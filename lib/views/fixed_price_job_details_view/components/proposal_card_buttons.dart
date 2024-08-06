import 'package:flutter/material.dart';
import 'package:xilancer/models/job_details_model.dart';

import '../../../helper/extension/context_extension.dart';
import '../../../helper/local_keys.g.dart';
import '../../../view_models/fix_price_job_details_view_model/fix_price_job_details_view_model.dart';
import '../../../views/proposal_details_view/proposal_details_view.dart';

class ProposalCardButtons extends StatelessWidget {
  const ProposalCardButtons({
    super.key,
    required this.id,
    required this.hired,
    required this.rejected,
    required this.shortlisted,
    required this.freelancerId,
    required this.freelancerName,
    required this.freelancerImage,
  });

  final id;
  final shortlisted;
  final hired;
  final rejected;
  final freelancerName;
  final freelancerImage;
  final freelancerId;

  @override
  Widget build(BuildContext context) {
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
                context.toPage(ProposalDetailsView(
                  proposalId: id,
                ));
              },
              child: Text(
                LocalKeys.viewDetails,
                textAlign: TextAlign.center,
                style: context.titleMedium?.bold6.copyWith(
                  color: context.dProvider.whiteColor,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: VerticalDivider(
              color: context.dProvider.whiteColor.withOpacity(.20),
              thickness: 2,
            ),
          ),
          PopupMenuButton(
            onSelected: (value) {
              final jdm = FixPriceJobDetailsViewModel.instance;
              switch (value) {
                case "reject":
                  jdm.tryRejecting(
                    context,
                    id: id,
                  );
                  break;
                default:
                  jdm.tryAddingShortList(
                    context,
                    id: id,
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
