import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:xilancer/helper/extension/string_extension.dart';

import '../../../helper/local_keys.g.dart';
import '../../../helper/svg_assets.dart';

class ChatBubble extends StatelessWidget {
  final bool senderFromWeb;
  final String message;
  final String? attachment;
  final String? path;
  const ChatBubble(
      {required this.senderFromWeb,
      super.key,
      required this.message,
      this.attachment,
      this.path});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment:
              senderFromWeb ? MainAxisAlignment.start : MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: senderFromWeb
              ? widgetList(context, message,
                  attachment == null ? null : "$path/$attachment")
              : widgetList(context, message,
                      attachment == null ? null : "$path/$attachment")
                  .reversed
                  .toList(),
        ),
      ],
    );
  }

  widgetList(BuildContext context, message, attachment) => [
        Column(
            crossAxisAlignment: senderFromWeb
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                constraints: BoxConstraints(maxWidth: context.width - 84),
                decoration: BoxDecoration(
                    color: senderFromWeb
                        ? context.dProvider.whiteColor
                        : context.dProvider.primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(12),
                      bottomRight: const Radius.circular(12),
                      topRight: senderFromWeb
                          ? const Radius.circular(12)
                          : const Radius.circular(0),
                      topLeft: senderFromWeb
                          ? const Radius.circular(0)
                          : const Radius.circular(12),
                    )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      textAlign: senderFromWeb ? null : TextAlign.end,
                      style: context.titleMedium?.copyWith(
                          fontSize: 14,
                          color: senderFromWeb
                              ? null
                              : context.dProvider.whiteColor),
                    ),
                    if (attachment != null)
                      TextButton.icon(
                        onPressed: () async {
                          await urlLauncher.launch(attachment ?? "");
                        },
                        icon: SvgAssets.documentDownload.toSVGSized(20,
                            color: senderFromWeb
                                ? context.dProvider.primaryColor
                                : context.dProvider.whiteColor),
                        label: Text(LocalKeys.downloadAttachment),
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            foregroundColor: !senderFromWeb
                                ? context.dProvider.whiteColor
                                : null),
                      )
                  ],
                ),
              ),
              8.toHeight,
            ])
      ];
}
