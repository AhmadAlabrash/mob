import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class ProposalDetailsCoverLetter extends StatelessWidget {
  final String? coverLetter;
  const ProposalDetailsCoverLetter({
    super.key,
    this.coverLetter,
  });

  @override
  Widget build(BuildContext context) {
    return coverLetter == null
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
                  LocalKeys.coverLetter,
                  style: context.titleMedium?.bold6,
                ).hp20,
                20.toHeight,
                Divider(
                  color: context.dProvider.black8,
                  thickness: 2,
                  height: 16,
                ),
                Text(
                  coverLetter!,
                  style: context.titleSmall,
                ).hp20,
              ],
            ),
          );
  }
}
