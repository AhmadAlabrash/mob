import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/conversation_service.dart';
import 'package:xilancer/utils/components/custom_network_image.dart';

import '../../../helper/svg_assets.dart';

class AttachmentBubble extends StatelessWidget {
  final file;
  final senderFromWeb;
  const AttachmentBubble({super.key, this.file, this.senderFromWeb});

  @override
  Widget build(BuildContext context) {
    bool isImage = false;
    bool isFile = false;
    bool isPdf = false;
    var filePath = "";
    if (file is File) {
      isFile = true;
    } else if (file is String && isImageUrl(file)) {
      isImage = true;
      filePath =
          "${Provider.of<ConversationService>(context, listen: false).conversationModel.attachmentPath.toString().replaceAll("https://", "")}/$file";
    } else if (file is String && file.toString().endsWith(".pdf")) {
      isPdf = true;
      debugPrint(file.toString());
      debugPrint("will show pdf ${!(isFile || isImage || file is! String)}"
          .toString());
      filePath =
          "${Provider.of<ConversationService>(context, listen: false).conversationModel.attachmentPath.toString().replaceAll("https://", "")}/$file";
    }
    return !(isFile || isImage || isPdf)
        ? const SizedBox()
        : InkWell(
            onTap: () async {
              if (isPdf) {
                debugPrint(filePath.toString());

                final Uri launchUri = Uri(
                  scheme: 'https',
                  path: filePath,
                );
                await urlLauncher.launchUrl(launchUri);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              constraints:
                  BoxConstraints(maxWidth: context.width - 84, minHeight: 52),
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
                ),
              ),
              child: (isFile && isImageFile(file.path.toString()) || isImage)
                  ? CustomNetworkImage(
                      radius: 12,
                      filePath: isFile ? file?.path : null,
                      imageUrl:
                          "${Provider.of<ConversationService>(context, listen: false).conversationModel.attachmentPath.toString()}/$file"
                              .toString(),
                      userPreloader: true,
                      errorWidget: const SizedBox(),
                    )
                  : FittedBox(
                      child: Row(
                        children: [
                          if (!isFile)
                            SvgAssets.documentDownload.toSVGSized(18,
                                color: senderFromWeb
                                    ? context.dProvider.primaryColor
                                    : context.dProvider.whiteColor),
                          6.toWidth,
                          Text(
                            isFile
                                ? basename(file.path)
                                : LocalKeys.downloadAttachment,
                            textAlign: senderFromWeb ? null : TextAlign.end,
                            style: context.titleMedium?.copyWith(
                                fontSize: 14,
                                color: senderFromWeb
                                    ? context.dProvider.primaryColor
                                    : context.dProvider.whiteColor),
                          ),
                        ],
                      ),
                    ),
            ),
          );
  }

  bool isImageUrl(String url) {
    return url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg') ||
        url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.gif');
  }

  bool isImageFile(String path) {
    return path.toLowerCase().endsWith('.jpg') ||
        path.toLowerCase().endsWith('.jpeg') ||
        path.toLowerCase().endsWith('.png') ||
        path.toLowerCase().endsWith('.gif');
  }
}
