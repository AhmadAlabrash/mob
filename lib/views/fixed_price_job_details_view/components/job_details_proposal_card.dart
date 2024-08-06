import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/models/project_details_model.dart';
import 'package:xilancer/views/fixed_price_job_details_view/components/proposal_status.dart';

import '../../../helper/extension/context_extension.dart';
import '../../../helper/extension/int_extension.dart';
import '../../../helper/extension/widget_extension.dart';
import '../../../helper/local_keys.g.dart';
import '../../../helper/pusher_helper.dart';
import '../../../services/chat_list_service.dart';
import '../../../services/profile_info_service.dart';
import '../../../views/proposal_details_view/components/proposal_details_buttons.dart';
import '../../../helper/image_assets.dart';
import '../../chat_list_view/components/chat_tile_avatar.dart';
import '../../conversation_view/conversation_view.dart';
import 'proposal_budget_duration.dart';
import 'proposal_card_buttons.dart';

class JobDetailsProposalCard extends StatelessWidget {
  final title;
  final occupation;
  final location;
  final rating;
  final ratingCount;
  final jobCompleteCount;
  final submitDate;
  final String offeredPrice;
  final estDuration;
  final image;
  final seen;
  final shortlisted;
  final hired;
  final rejected;
  final interviewed;
  final freelancerId;
  final id;
  final bool fromDetails;
  final ChatInfo? chatInfo;
  const JobDetailsProposalCard({
    super.key,
    this.id,
    this.title,
    this.occupation,
    this.location,
    this.ratingCount,
    this.rating,
    this.jobCompleteCount,
    this.submitDate,
    required this.offeredPrice,
    this.image,
    this.estDuration,
    this.seen,
    this.shortlisted,
    this.hired,
    this.rejected,
    this.freelancerId,
    this.interviewed,
    this.fromDetails = false,
    this.chatInfo,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(chatInfo.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        4.toHeight,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ChatTileAvatar(
              placeHolderImage: ImageAssets.avatar,
              name: title,
              size: 44.0,
              imageUrl: image.toString(),
            )),
            Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.titleMedium?.bold6,
                    ),
                    8.toHeight,
                    Text(
                      "$occupation . $location",
                      style: context.titleSmall?.bold5
                          .copyWith(color: context.dProvider.black5),
                    ),
                    8.toHeight,
                  ],
                ))
          ],
        ),
        ProposalStatus(
            rating: rating,
            ratingCount: ratingCount,
            hired: hired,
            rejected: rejected,
            jobCompleteCount: jobCompleteCount,
            submitDate: submitDate),
        8.toHeight,
        Divider(
          color: context.dProvider.black8,
          thickness: 2,
          height: 16,
        ),
        ProposalBudgetDuration(
            offeredPrice: offeredPrice, estDuration: estDuration),
        12.toHeight,
        Row(
          children: [
            Expanded(
                flex: 1,
                child: OutlinedButton(
                    onPressed: () {
                      final pi = Provider.of<ProfileInfoService>(context,
                          listen: false);
                      final profileInfo = pi.profileInfoModel.data!;
                      Provider.of<ChatListService>(context, listen: false)
                          .setChatRead(chatInfo?.id);

                      PusherHelper().connectToPusher(
                          context, profileInfo.id, chatInfo?.freelancerId);
                      context.toNamed(ConversationView.routeName, arguments: [
                        chatInfo?.id ?? "",
                        "$title",
                        "$image",
                        chatInfo?.freelancerId
                      ], then: () {
                        PusherHelper().disConnect();
                      });
                    },
                    child: Text(LocalKeys.sendMessage))),
          ],
        ),
        12.toHeight,
        if (fromDetails)
          ProposalDetailsButtons(
            proposalId: id,
            hired: hired,
            rejected: rejected,
            shortlisted: shortlisted,
            chatInfo: chatInfo,
          ),
        if (!fromDetails)
          ProposalCardButtons(
            id: id,
            hired: hired,
            rejected: rejected,
            shortlisted: shortlisted,
            freelancerId: freelancerId,
            freelancerImage: image,
            freelancerName: title,
          ),
      ],
    ).hp20;
  }
}
