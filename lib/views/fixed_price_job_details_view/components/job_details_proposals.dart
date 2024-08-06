import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/job_details_service.dart';
import 'package:xilancer/views/fixed_price_job_details_view/components/job_details_proposal_card.dart';

class JobDetailsProposals extends StatelessWidget {
  final int tabIndex;
  const JobDetailsProposals({super.key, required this.tabIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobDetailsService>(builder: (context, jd, child) {
      final jp = jd.proposalList(tabIndex);
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
              LocalKeys.proposals,
              style: context.titleMedium?.bold6,
            ).hp20,
            20.toHeight,
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 16,
            ),
            if (jp.isEmpty)
              Text(
                LocalKeys.noProposalsYet,
                style: context.titleSmall?.copyWith(
                  color: context.dProvider.black5,
                ),
              ).hp20,
            ...jp.sublist(0, jp.length < 10 ? jp.length : 10).map((e) => Column(
                  children: [
                    JobDetailsProposalCard(
                      image: e.freelancer?.image?.profileImage,
                      id: e.id,
                      freelancerId: e.freelancer?.id,
                      chatInfo: e.chatInfo,
                      title:
                          "${e.freelancer?.firstName ?? ""} ${e.freelancer?.lastName ?? ""}",
                      occupation: e.intro?.title ?? "",
                      rating: e.freelancerAvgRating,
                      ratingCount: e.freelancerRatingCount,
                      jobCompleteCount: e.completeOrderCount,
                      submitDate: e.createdAt ?? DateTime.now(),
                      location:
                          "${e.country?.country ?? ""}, ${e.state?.state ?? ""}",
                      offeredPrice: (e.amount ?? 0).toStringAsFixed(0),
                      estDuration: e.duration,
                      hired: e.isHired.toString() == "1",
                      shortlisted: e.isShortListed.toString() == "1",
                      rejected: e.isRejected.toString() == "1",
                      interviewed: e.isInterviewTake.toString() == "1",
                    ),
                    if (jp.last.id.toString() != e.id.toString())
                      Divider(
                        color: context.dProvider.black8,
                        thickness: 2,
                        height: 16,
                      )
                  ],
                )),
          ],
        ),
      );
    });
  }
}
