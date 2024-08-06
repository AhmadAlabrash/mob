import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/job_details_service.dart';
import 'package:xilancer/views/proposal_details_view/components/proposal_details_attachment.dart';
import 'package:xilancer/views/proposal_details_view/components/proposal_details_cover_letter.dart';

import '../../models/job_details_model.dart';
import '../fixed_price_job_details_view/components/job_details_proposal_card.dart';

class ProposalDetailsView extends StatelessWidget {
  final proposalId;
  const ProposalDetailsView({super.key, this.proposalId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<JobDetailsService>(builder: (context, jd, child) {
        JobProposal? e;
        try {
          e = jd.jobDetailsModel.jobDetails?.jobProposals?.firstWhere(
              (element) => element.id.toString() == proposalId.toString());
        } catch (error) {
          e = null;
        }
        return e == null
            ? const SizedBox()
            : ListView(
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.dProvider.whiteColor,
                    ),
                    child: JobDetailsProposalCard(
                      image: e.freelancer?.image?.profileImage,
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
                      fromDetails: true,
                      chatInfo: e.chatInfo,
                      id: e.id,
                    ),
                  ),
                  20.toHeight,
                  ProposalDetailsAttachment(
                    attachment: e.attachment,
                  ),
                  20.toHeight,
                  ProposalDetailsCoverLetter(
                    coverLetter: e.coverLetter,
                  ),
                ],
              );
      }),
    );
  }
}
