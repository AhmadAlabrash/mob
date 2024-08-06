import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../../../helper/svg_assets.dart';

class ProposalDetailsAttachment extends StatelessWidget {
  final String? attachment;
  const ProposalDetailsAttachment({
    super.key,
    this.attachment,
  });

  @override
  Widget build(BuildContext context) {
    return (attachment ?? "").isEmpty
        ? const SizedBox()
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.dProvider.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocalKeys.attachments,
                  style: context.titleMedium?.bold6,
                ).hp20,
                20.toHeight,
                Divider(
                  color: context.dProvider.black8,
                  thickness: 2,
                  height: 16,
                ),
                TextButton.icon(
                  onPressed: () async {
                    await urlLauncher
                        .launch(attachment.toString().jobProposalAttachment);
                  },
                  icon: SvgAssets.documentDownload
                      .toSVGSized(20, color: context.dProvider.primaryColor),
                  label: Text(LocalKeys.downloadAttachment),
                  style: TextButton.styleFrom(padding: EdgeInsets.zero),
                ).hp20,
              ],
            ),
          );
  }
}
