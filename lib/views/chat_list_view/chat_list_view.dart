import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/chat_list_service.dart';
import '../../services/profile_info_service.dart';
import '../../utils/components/custom_preloader.dart';
import '../../utils/components/empty_widget.dart';
import '../../utils/components/scrolling_preloader.dart';
import '../account_skeleton/account_skeleton.dart';
import '/helper/extension/context_extension.dart';
import '/utils/components/custom_future_widget.dart';
import '../../view_models/chat_list_view_model/chat_list_view_model.dart';
import 'components/chat_tile.dart';
import '/views/chat_list_view/components/chat_tiles_shimmer.dart';

import '/helper/local_keys.g.dart';
import '/utils/components/custom_refresh_indicator.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    final clProvider = Provider.of<ChatListService>(context, listen: false);
    final clv = ChatListViewModel.instance;
    clv.scrollController.addListener(() {
      clv.tryLoadingMore(context);
    });
    return Column(
      children: [
        AppBar(
          leadingWidth: 0,
          leading: const SizedBox(),
          title: Text(LocalKeys.inbox),
        ),
        16.toHeight,
        Consumer<ProfileInfoService>(builder: (context, pi, child) {
          return Expanded(
            child: pi.profileInfoModel.data == null
                ? Column(
                    children: [
                      const Expanded(child: AccountSkeleton()),
                      16.toHeight,
                    ],
                  )
                : CustomRefreshIndicator(
                    onRefresh: () async {
                      await clProvider.fetchChatList();
                    },
                    child: CustomFutureWidget(
                        function: clProvider.shouldAutoFetch
                            ? clProvider.fetchChatList()
                            : null,
                        shimmer: const ChatTileShimmer(),
                        child: Consumer<ChatListService>(
                            builder: (context, cl, child) {
                          return (cl.chatListModel.chatList?.chats?.length ??
                                      0) <
                                  1
                              ? EmptyWidget(
                                  title: LocalKeys.noConversationsToDisplay)
                              : Scrollbar(
                                  controller: clv.scrollController,
                                  child: Container(
                                    color: context.dProvider.whiteColor,
                                    padding: const EdgeInsets.all(20),
                                    child: ListView.separated(
                                        padding: EdgeInsets.zero,
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        controller: clv.scrollController,
                                        itemBuilder: (context, index) {
                                          if ((cl.nextPage != null &&
                                                  !cl.nexLoadingFailed) &&
                                              index ==
                                                  cl.chatListModel.chatList!
                                                      .chats!.length) {
                                            return ScrollPreloader(
                                                loading: cl.nextPageLoading);
                                          }
                                          final chatItem = cl.chatListModel
                                              .chatList!.chats![index];
                                          // if (chatItem.clientId.toString() ==
                                          //         chatItem.freelancerId
                                          //             .toString() ||
                                          //     chatItem.freelancer == null) {
                                          //   return const SizedBox();
                                          // }
                                          return ChatTile(
                                              id: chatItem.id,
                                              clientId: chatItem.clientId,
                                              freelancerId:
                                                  chatItem.freelancerId,
                                              unRead: chatItem
                                                      .clientUnseenMsgCount >
                                                  0,
                                              isActive: cl.chatListModel.activeUsers
                                                      ?.contains(chatItem
                                                          .freelancerId
                                                          .toString()) ??
                                                  false,
                                              unreadCount:
                                                  chatItem.clientUnseenMsgCount,
                                              activityString: cl.chatListModel
                                                      .activityCheck[
                                                  chatItem.freelancerId
                                                      .toString()],
                                              name: chatItem.freelancer == null
                                                  ? "----"
                                                  : "${chatItem.freelancer?.firstName} ${chatItem.freelancer?.lastName ?? ""}",
                                              imageUrl:
                                                  "${cl.chatListModel.profileImagePath}/${(chatItem.freelancer?.image).toString()}");
                                        },
                                        separatorBuilder: (context, index) =>
                                            (index ==
                                                    (cl.chatListModel.chatList!
                                                            .chats!.length -
                                                        1))
                                                ? const SizedBox()
                                                : Divider(
                                                    color: context
                                                        .dProvider.black8,
                                                    thickness: 1,
                                                  ),
                                        itemCount: cl.chatListModel.chatList!
                                                .chats!.length +
                                            (cl.nextPage != null &&
                                                    !cl.nexLoadingFailed
                                                ? 1
                                                : 0)),
                                  ),
                                );
                        })),
                  ),
          );
        })
      ],
    );
  }

  delay() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
