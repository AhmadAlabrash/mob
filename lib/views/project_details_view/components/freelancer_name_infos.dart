import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/customizations.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/models/project_details_model.dart';
import 'package:xilancer/services/profile_details_service.dart';
import 'package:xilancer/services/profile_info_service.dart';
import 'package:xilancer/views/chat_list_view/components/chat_tile_avatar.dart';
import 'package:xilancer/views/profile_details_view/profile_details_view.dart';

import '../../../helper/local_keys.g.dart';
import '../../../helper/pusher_helper.dart';
import '../../../services/chat_list_service.dart';
import '../../../services/project_details_service.dart';
import '../../conversation_view/conversation_view.dart';

class FreelancerNameInfos extends StatelessWidget {
  final ProjectCreator? userDetails;
  final projectId;
  const FreelancerNameInfos({
    super.key,
    this.userDetails,
    this.projectId,
  });

  @override
  Widget build(BuildContext context) {
    final pdProvider =
        Provider.of<ProjectDetailsService>(context, listen: false);
    final pi = Provider.of<ProfileInfoService>(context, listen: false);
    final project = pdProvider.projectDetailsModel[projectId.toString()];
    final freelancerRating = project?.freelancerRating ?? 0;
    final freelancerTotalRating = project?.freelancerTotalRating ?? 0;
    final completeOrdersCount = project?.completeOrdersCount ?? 0;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: ChatTileAvatar(
              imageUrl: "$userProfilePath/${userDetails?.image}",
              name:
                  "${userDetails?.firstName ?? ""} ${userDetails?.lastName ?? ""}",
              size: 60.0),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: userDetails?.userActiveInactiveStatus ?? false
                          ? context.dProvider.greenColor
                          : context.dProvider.black3,
                    )),
                child: FittedBox(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 4,
                        backgroundColor:
                            userDetails?.userActiveInactiveStatus ?? false
                                ? context.dProvider.greenColor
                                : context.dProvider.black3,
                      ),
                      4.toWidth,
                      Text(
                        userDetails?.userActiveInactiveStatus ?? false
                            ? LocalKeys.active
                            : LocalKeys.inactive,
                        style: context.titleSmall
                            ?.copyWith(
                                color: userDetails?.userActiveInactiveStatus
                                    ? context.dProvider.greenColor
                                    : context.dProvider.black3)
                            .bold6,
                      ),
                    ],
                  ),
                ),
              ),
              8.toHeight,
              Text(
                "${userDetails?.firstName ?? ""} ${userDetails?.lastName ?? ""}",
                style: context.titleMedium?.bold6,
              ),
              8.toHeight,
              Wrap(
                runSpacing: 12,
                spacing: 12,
                children: [
                  if (userDetails?.userIntroduction?.title != null) ...[
                    Text(
                      userDetails?.userIntroduction?.title ?? "",
                      style: context.titleSmall
                          ?.copyWith(color: context.dProvider.black5),
                    )
                  ],
                  if (freelancerTotalRating > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: context.dProvider.yellowColor.withOpacity(0.10),
                      ),
                      child: FittedBox(
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: context.dProvider.yellowColor,
                              size: 20,
                            ),
                            Text(
                              " $freelancerRating ($freelancerTotalRating)",
                              style: context.titleSmall
                                  ?.copyWith(
                                      color: context.dProvider.yellowColor)
                                  .bold6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (completeOrdersCount > 0)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: context.dProvider.greenColor.withOpacity(0.10),
                      ),
                      child: Text(
                        completeOrdersCount > 0
                            ? "$completeOrdersCount ${LocalKeys.ordersCompleted}"
                            : LocalKeys.noOrder,
                        style: context.titleSmall
                            ?.copyWith(color: context.dProvider.greenColor)
                            .bold6,
                      ),
                    ),
                ],
              ),
              6.toHeight,
              Row(
                children: [
                  OutlinedButton(
                      onPressed: () {
                        context.toPage(ProfileDetailsView(
                          username: userDetails?.username,
                          userActiveStatus:
                              userDetails?.userActiveInactiveStatus,
                        ));
                      },
                      child: Text(LocalKeys.viewProfile)),
                  12.toWidth,
                  if (pi.profileInfoModel.data != null)
                    GestureDetector(
                        onTap: () {
                          final profileInfo = pi.profileInfoModel.data!;
                          Provider.of<ChatListService>(context, listen: false)
                              .setChatRead(project?.chatInfo?.id);

                          PusherHelper().connectToPusher(
                              context,
                              profileInfo.id,
                              project?.projectDetails?.projectCreator?.id);
                          context
                              .toNamed(ConversationView.routeName, arguments: [
                            project?.chatInfo?.id ?? "",
                            "${project?.projectDetails?.projectCreator?.firstName} ${project?.projectDetails?.projectCreator?.lastName}",
                            "$userProfilePath/${userDetails?.image}",
                            project?.projectDetails?.projectCreator?.id
                          ], then: () {
                            PusherHelper().disConnect();
                          });
                        },
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: context.dProvider.primaryColor,
                          child: SvgAssets.messageBold.toSVGSized(24,
                              color: context.dProvider.whiteColor),
                        ))
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
