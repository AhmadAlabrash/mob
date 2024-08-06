import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/chat_list_service.dart';
import 'package:xilancer/services/message_notification_count_service.dart';
import '../../../helper/pusher_helper.dart';
import '/views/conversation_view/conversation_view.dart';
import 'package:timeago/timeago.dart' as timeAgo;

import '/helper/extension/context_extension.dart';
import '../../../utils/components/empty_spacer_helper.dart';
import 'chat_tile_avatar.dart';

class ChatTile extends StatelessWidget {
  final unRead;
  final name;
  final imageUrl;
  final uDate;
  final clientId;
  final freelancerId;
  final id;
  final isActive;
  final activityString;
  final unreadCount;

  const ChatTile({
    super.key,
    required this.id,
    required this.unRead,
    this.name,
    this.imageUrl,
    this.uDate,
    this.clientId,
    this.freelancerId,
    this.isActive,
    this.activityString,
    this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Provider.of<ChatListService>(context, listen: false).setChatRead(id);
        PusherHelper().connectToPusher(context, clientId, freelancerId);
        context.toNamed(ConversationView.routeName,
            arguments: [id, name, imageUrl, freelancerId], then: () {
          PusherHelper().disConnect();
        });
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: unRead ? context.dProvider.primary05 : null,
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  alignment: context.dProvider.textDirectionRight
                      ? Alignment.bottomLeft
                      : Alignment.bottomRight,
                  children: [
                    ChatTileAvatar(
                      name: name,
                      imageUrl: imageUrl,
                      color: context.dProvider.chatAvatarBGColors[
                          (int.tryParse(id.toString()) ??
                                  Random().nextInt(1632)) %
                              context.dProvider.chatAvatarBGColors.length],
                    ),
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: context.dProvider.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        radius: 6,
                        backgroundColor: isActive != true
                            ? context.dProvider.black6
                            : context.dProvider.greenColor,
                      ),
                    )
                  ],
                ),
                EmptySpaceHelper.emptyWidth(12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: context.width - 144,
                          child: Text(
                            name,
                            style: context.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    6.toHeight,
                    if (activityString != null)
                      SizedBox(
                        width: ((context.width - 144)),
                        child: Text(
                          activityString,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: context.dProvider.black5),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (unRead)
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Align(
                  alignment: context.dProvider.textDirectionRight
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: context.dProvider.primaryColor,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
