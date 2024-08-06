import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '/helper/extension/context_extension.dart';
import '/helper/extension/string_extension.dart';
import '/utils/components/empty_spacer_helper.dart';
import '../../../helper/local_keys.g.dart';
import '../../../helper/svg_assets.dart';
import '../../../utils/components/field_label.dart';

class IdCardSelect extends StatelessWidget {
  const IdCardSelect({
    super.key,
    required this.suv,
  });

  final suv;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label: LocalKeys.uploadYourIdCard),
        ValueListenableBuilder(
          valueListenable: suv.idCard,
          builder: (context, value, child) {
            return InkWell(
              child: Stack(
                children: [
                  Container(
                      height: 46,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: context.dProvider.black8,
                          )),
                      child: Row(
                        children: [
                          SvgAssets.gallery.toSVG,
                          EmptySpaceHelper.emptyWidth(12),
                          SizedBox(
                            width: context.width - (context.width / 1.8),
                            child: Text(
                              value != null
                                  ? basename(suv.idCard.value.path)
                                  : LocalKeys.noSelectedFile,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: context.titleSmall?.copyWith(
                                color: context.dProvider.black5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      )),
                  InkWell(
                    onTap: () async {
                      if (value != null) {
                        suv.idCard.value = null;
                        LocalKeys.fileRemoved.showToast();
                        return;
                      }
                      try {
                        PickedFile? file = await ImagePicker.platform.pickImage(
                            source: ImageSource.gallery,
                            maxHeight: 1920,
                            maxWidth: 1080);
                        if (file == null) {
                          return;
                        }
                        suv.idCard.value = File(file.path);
                        LocalKeys.fileSelected.showToast();
                      } catch (error) {
                        LocalKeys.fileSelectFailed.showToast();
                      }
                    },
                    child: Align(
                      alignment: context.dProvider.textDirectionRight
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        height: 46,
                        width: context.width / 3.5,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: context.dProvider.black8,
                            )),
                        child: Text(
                          value != null
                              ? LocalKeys.clearFile
                              : LocalKeys.selectFile,
                          style: context.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.dProvider.black2),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ),
        EmptySpaceHelper.emptyHeight(16),
      ],
    );
  }
}
