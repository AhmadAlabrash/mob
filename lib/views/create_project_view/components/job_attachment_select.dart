import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';

import '/helper/extension/context_extension.dart';
import '/helper/extension/string_extension.dart';
import '/utils/components/empty_spacer_helper.dart';
import '../../../helper/local_keys.g.dart';
import '../../../helper/svg_assets.dart';
import '../../../utils/components/field_label.dart';

class JobAttachmentSelect extends StatelessWidget {
  const JobAttachmentSelect({
    super.key,
    required this.suv,
  });

  final CreateJobViewModel suv;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label: LocalKeys.attachFile),
        ValueListenableBuilder(
          valueListenable: suv.selectedAttachment,
          builder: (context, value, child) {
            return InkWell(
              onTap: () async {
                if (value != null) {
                  suv.selectedAttachment.value = null;
                  LocalKeys.fileRemoved.showToast();
                  return;
                }
                try {
                  FilePickerResult? file =
                      await FilePicker.platform.pickFiles();
                  if (file?.files.firstOrNull?.path == null) {
                    return;
                  }
                  suv.selectedAttachment.value = File(file!.files.first.path!);
                  LocalKeys.fileSelected.showToast();
                } catch (error) {
                  LocalKeys.fileSelectFailed.showToast();
                }
              },
              child: Container(
                height: 46,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: context.dProvider.black9,
                    )),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: SvgAssets.gallery.toSVG,
                    ),
                    Expanded(
                      child: SizedBox(
                        width: context.width - (context.width / 1.8),
                        child: Text(
                          value != null
                              ? basename(value.path)
                              : LocalKeys.noSelectedFile,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.titleSmall?.copyWith(
                            color: value != null
                                ? context.dProvider.black3
                                : context.dProvider.black5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
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
                                color: context.dProvider.black9,
                              )),
                          child: Text(
                            value != null
                                ? LocalKeys.clearFile
                                : LocalKeys.selectFile,
                            style: context.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.dProvider.black3),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
        EmptySpaceHelper.emptyHeight(16),
      ],
    );
  }
}
