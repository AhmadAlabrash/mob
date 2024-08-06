import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

import '../../../helper/local_keys.g.dart';
import '../../../helper/svg_assets.dart';

class SendOfferAttachmentButton extends StatelessWidget {
  final ValueNotifier<File?> fileNotifier;
  const SendOfferAttachmentButton({super.key, required this.fileNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: fileNotifier,
        builder: (context, file, child) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 26,
                  child: GestureDetector(
                    onTap: choseAttachment,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: context.dProvider.black9,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgAssets.paperclip
                              .toSVGSized(18, color: context.dProvider.black5),
                          6.toWidth,
                          Container(
                            constraints: BoxConstraints(
                              maxWidth: context.width - 150,
                            ),
                            child: Text(
                              file?.path == null
                                  ? LocalKeys.attachFile
                                  : basename(file?.path ?? ""),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.titleSmall?.bold
                                  .copyWith(color: context.dProvider.black5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (file != null) ...[
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                      flex: 4,
                      child: IconButton(
                        icon: SvgAssets.trash.toSVGSized(24,
                            color: context.dProvider.warningColor),
                        onPressed: () {
                          fileNotifier.value = null;
                        },
                      ))
                ]
              ],
            ));
  }

  choseAttachment() async {
    if (fileNotifier.value != null) {
      fileNotifier.value = null;
      LocalKeys.fileRemoved.showToast();
      return;
    }
    try {
      final file = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowMultiple: false,
          allowedExtensions: [
            'png',
            'jpg',
            'jpeg',
            'bmp',
            'gif',
            'tiff',
            'svg',
            'csv',
            'txt',
            'xlsx',
            'xls',
            'pdf'
          ]);

      if (file?.files.isEmpty ?? true) {
        return;
      }
      fileNotifier.value = File(file!.files[0].path!);
      LocalKeys.fileSelected.showToast();
    } catch (e) {
      debugPrint(e.toString());
      LocalKeys.fileSelectFailed.showToast();
    }
  }
}
