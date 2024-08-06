import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/models/job_details_model.dart';

import 'activity_info.dart';

class FixedPriceJobDetailsActivity extends StatelessWidget {
  JobDetailsModel jobDetailsModel;
  FixedPriceJobDetailsActivity({
    super.key,
    required this.jobDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    if (jobDetailsModel.jobDetails?.jobProposals?.isEmpty ?? true) {
      return const SizedBox();
    }
    List proposals = jobDetailsModel.jobDetails!.jobProposals!.toSet().toList();
    proposals.sort((a, b) => b?.updatedAt?.compareTo(a?.updatedAt) ?? 0);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalKeys.activities,
            style: context.titleMedium?.bold6,
          ).hp20,
          20.toHeight,
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 16,
          ),
          ...proposals.map((e) {
            final fullName =
                "${e.freelancer?.firstName ?? ""} ${e.freelancer?.lastName ?? ""}";
            String prefix = "";
            bool isLast = proposals.indexOf(e) == (proposals.length - 1);
            if (e.isRejected.toString() == "1") {
              prefix = LocalKeys.rejected;
            } else if (e.isHired.toString() == "1") {
              prefix = LocalKeys.hired;
            } else if (e.isInterviewTake.toString() == "1") {
              prefix = LocalKeys.interviewed;
            } else if (e.isShortListed.toString() == "1") {
              prefix = LocalKeys.shortListed;
            } else {
              prefix = LocalKeys.proposalFrom;
            }
            return ActivityInfo(
              title: fullName,
              prefix: prefix,
              date: e.updatedAt,
              isLast: isLast,
            );
          }).toList(),
        ],
      ),
    );
  }
}
