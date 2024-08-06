import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';

import '../../../helper/local_keys.g.dart';

class PersonalNoteCard extends StatelessWidget {
  const PersonalNoteCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 20),
          childrenPadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: context.dProvider.black8,
              )),
          collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: context.dProvider.black8,
              )),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocalKeys.researchAboutProject,
                style: context.titleMedium?.bold6,
              ),
            ],
          ),
          children: [
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
            ),
            8.toHeight,
            Text(
              "The worst client I've ever dealt with. I was made to work on multiple different projects on purpose. He himself warned me not to pay. Who on earth would treat their Freelancer that way? Don’t work with him. You’ll lose your account",
              style:
                  context.titleSmall?.copyWith(color: context.dProvider.black5),
            ).hp20,
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
            ),
            8.toHeight,
            Row(
              children: [
                Expanded(
                  flex: 12,
                  child: OutlinedButton(
                    onPressed: () {},
                    child: Text(LocalKeys.deleteNote),
                  ),
                ),
                const Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 12,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(LocalKeys.editNote),
                  ),
                )
              ],
            ).hp20,
            8.toHeight,
          ],
        ),
      ],
    ).hp20;
  }
}
