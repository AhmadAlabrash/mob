import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/profile_info_service.dart';
import 'package:xilancer/utils/components/empty_widget.dart';
import 'package:xilancer/view_models/conversation_view_model/conversation_view_model.dart';
import '../../../models/conversation_model.dart';
import '../../../services/conversation_service.dart';
import '../../../utils/components/custom_preloader.dart';
import '../../../utils/components/scrolling_preloader.dart';
import '/utils/components/empty_spacer_helper.dart';

import 'chat_bubble.dart';

class ConversationMessageList extends StatelessWidget {
  final ConversationService cs;
  final clientImage;
  final name;
  const ConversationMessageList({
    super.key,
    required this.cs,
    required this.clientImage,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    final piProvider = Provider.of<ProfileInfoService>(context, listen: false);
    final cm = ConversationViewModel.instance;
    cm.scrollController.addListener(() {
      cm.tryLoadingMore(context);
    });
    return (cs.conversationModel.allMessage?.data?.length ?? 0) < 1
        ? EmptyWidget(
            title: LocalKeys.noMessageFound,
          )
        : ListView.separated(
            controller: cm.scrollController,
            padding: const EdgeInsets.all(20),
            reverse: true,
            itemBuilder: (context, index) {
              if ((cs.nextPage != null && !cs.nexLoadingFailed) &&
                  index == cs.conversationModel.allMessage!.data!.length) {
                return ScrollPreloader(
                  loading: cs.nextPageLoading,
                  text: LocalKeys.pullDown,
                  iconData: Icons.arrow_circle_down_rounded,
                );
              }
              Datum? previousMessage;
              if (index != 0) {
                previousMessage =
                    cs.conversationModel.allMessage!.data![index - 1];
              }
              final datum = cs.conversationModel.allMessage!.data![index];
              return ChatBubble(
                  datum: datum,
                  senderFromWeb: datum.fromUser.toString() == 2.toString(),
                  clientImage: datum.fromUser.toString() == 2.toString()
                      ? clientImage
                      : piProvider.profileInfoModel.data?.image,
                  name: datum.fromUser.toString() == 2.toString()
                      ? name
                      : piProvider.profileInfoModel.data?.firstName,
                  index: index,
                  sameUser: previousMessage?.fromUser.toString() ==
                      datum.fromUser.toString());
            },
            separatorBuilder: (context, index) =>
                EmptySpaceHelper.emptyHeight(12),
            itemCount: cs.conversationModel.allMessage!.data!.length +
                (cs.nextPage != null && !cs.nexLoadingFailed ? 1 : 0));
  }
}
