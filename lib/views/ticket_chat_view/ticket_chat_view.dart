import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/view_models/support_tickets_view_model/support_tickets_view_model.dart';

import '../../services/ticket_chat_service.dart';
import '../../utils/components/custom_preloader.dart';
import '../../utils/components/scrolling_preloader.dart';
import 'components/chat_bubble.dart';

class TicketChatView extends StatelessWidget {
  String title;
  final id;
  TicketChatView(this.title, this.id, {Key? key}) : super(key: key);
  Key textFieldKey = const Key('key');
  final TextEditingController _controller = TextEditingController();

  Future<void> imageSelector(
    BuildContext context,
  ) async {
    try {
      FilePickerResult? file = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'zip', 'png', 'jpeg'],
      );
      Provider.of<TicketChatService>(context, listen: false)
          .setPickedImage(File(file!.files.single.path as String));
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TicketChatService>(builder: (context, tcProvider, child) {
      return WillPopScope(
        onWillPop: () async {
          tcProvider.clearAllMessages();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            foregroundColor: context.dProvider.blackColor,
            centerTitle: true,
            title: RichText(
              softWrap: true,
              text: TextSpan(
                  text: '#$id',
                  style: TextStyle(
                      color: context.dProvider.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 19),
                  children: [
                    TextSpan(
                        text: ' $title',
                        style: TextStyle(color: context.dProvider.blackColor)),
                  ]),
            ),
            leading: NavigationPopIcon(
              onTap: () {
                tcProvider.clearAllMessages();
                Navigator.of(context).pop();
              },
            ),
          ),
          body: WillPopScope(
            onWillPop: () async {
              tcProvider.clearAllMessages();
              Navigator.of(context).pop();
              return true;
            },
            child: Consumer<TicketChatService>(
                builder: (context, tcProvider, child) {
              return Column(
                children: [
                  Expanded(
                    child: messageListView(context, tcProvider),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: context.dProvider.whiteColor,
                        borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: context.height / 7,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextField(
                              maxLines: 4,
                              controller: _controller,
                              decoration: InputDecoration(
                                isDense: true,
                                hintText: LocalKeys.writeMessage,
                                hintStyle: TextStyle(
                                    color: context.dProvider.black5,
                                    fontSize: 14),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                      color: context.dProvider.black8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: context.dProvider.black8),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: context.dProvider.black8),
                                ),
                              ),
                              onChanged: (value) {
                                tcProvider.setMessage(value);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Text(
                                LocalKeys.file,
                                style: TextStyle(
                                    color: context.dProvider.black5,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  imageSelector(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: context.dProvider.black8)),
                                  child: Text(
                                    LocalKeys.choseFile,
                                    style: TextStyle(
                                        color: context.dProvider.black5),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                width: context.width / 3,
                                child: Text(
                                  tcProvider.pickedImage == null
                                      ? LocalKeys.noFileChosen
                                      : tcProvider.pickedImage!.path
                                          .split('/')
                                          .last,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    side: BorderSide(
                                      width: 1,
                                      color: context.dProvider.black8,
                                    ),
                                    activeColor: context.dProvider.primaryColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        side: BorderSide(
                                          width: 1,
                                          color: context.dProvider.black8,
                                        )),
                                    value: tcProvider.notifyViaMail,
                                    onChanged: (value) {
                                      tcProvider.toggleNotifyViaMail(value);
                                    }),
                              ),
                              const SizedBox(width: 5),
                              RichText(
                                softWrap: true,
                                text: TextSpan(
                                  text: LocalKeys.notifyViaMail,
                                  style: TextStyle(
                                      color: context.dProvider.black5,
                                      fontSize: 13),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          physics: const NeverScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Stack(
                              children: [
                                CustomButton(
                                  btText: LocalKeys.send,
                                  isLoading: tcProvider.isLoading,
                                  onPressed: tcProvider.message == ''
                                      ? null
                                      : () async {
                                          tcProvider.setIsLoading(true);
                                          FocusScope.of(context).unfocus();
                                          await tcProvider
                                              .sendMessage(context,
                                                  tcProvider.ticketDetails!.id)
                                              .then((value) {
                                            if (value != null) {
                                              return;
                                            }
                                            _controller.clear();
                                          });
                                        },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SingleChildScrollView(
                            physics: NeverScrollableScrollPhysics(),
                            child: SizedBox(height: 25)),
                      ],
                    ),
                  )
                ],
              );
            }),
          ),
        ),
      );
    });
  }

  Widget messageListView(BuildContext context, TicketChatService tcProvider) {
    final stm = SupportTicketViewModel.instance;
    stm.chatScrollController.addListener(() {
      stm.tryToLoadMoreMessages(context);
    });
    if (tcProvider.ticketDetails == null) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CustomPreloader(),
          ),
        ],
      );
    } else if ((tcProvider.messagesList ?? []).isEmpty) {
      return Center(
        child: Text(
          LocalKeys.noMessageFound,
          style: TextStyle(color: context.dProvider.black5),
        ),
      );
    } else {
      return ListView.separated(
        controller: stm.chatScrollController,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        reverse: true,
        itemCount: tcProvider.messagesList.length +
            (!tcProvider.noMoreMessages ? 1 : 0),
        itemBuilder: ((context, index) {
          if (tcProvider.messagesList.length == index) {
            return ScrollPreloader(
              loading: tcProvider.nextPageLoading,
              text: LocalKeys.pullDown,
              iconData: Icons.arrow_circle_down_rounded,
            );
          }
          final element = tcProvider.messagesList[index];
          final usersMessage = element.type != 'admin';
          return ChatBubble(
            senderFromWeb: !usersMessage,
            message: element.message ?? "",
            path: tcProvider.attachmentPath,
            attachment: element.attachment,
          );
        }),
        separatorBuilder: (context, index) {
          return 8.toHeight;
        },
      );
    }
  }

  Widget showFile(
      BuildContext context, String? url, int id, AlignmentGeometry alignment) {
    print('Url is: $url');
    if (url != null &&
        (!url.contains('.png') &&
            !url.contains('.jpg') &&
            !url.contains('.jpeg'))) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        width: 50,
        child: SvgPicture.asset('assets/images/icons/zip_icon.svg'),
      );
    }
    return GestureDetector(
      onTap: () {},
      child: url != null
          ? GestureDetector(
              child: Container(
                alignment: alignment,
                constraints: BoxConstraints(maxWidth: context.width / 1.5),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.network(
                  url,
                  alignment: alignment,
                  loadingBuilder: (context, child, loding) {
                    if (loding == null) {
                      return child;
                    }
                    return Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              alignment: alignment,
                              image: const AssetImage(
                                'assets/images/app_icon.png',
                              ),
                              opacity: .4)),
                    );
                  },
                  errorBuilder: (context, str, some) {
                    return Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              alignment: alignment,
                              image: const AssetImage(
                                  'assets/images/app_icon.png'),
                              opacity: .4)),
                    );
                  },
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
