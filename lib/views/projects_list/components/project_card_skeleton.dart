import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/utils/components/text_skeleton.dart';

import '../../../helper/svg_assets.dart';

class ProjectCardSkeleton extends StatelessWidget {
  const ProjectCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: (context.width - 72) * 0.54237,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.dProvider.black8,
            ),
          ),
          ...[
            16.toHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextSkeleton(
                  height: 16,
                  width: 60,
                  color: context.dProvider.yellowColor.withOpacity(0.10),
                ),
                TextSkeleton(
                  height: 16,
                  width: 80,
                  color: context.dProvider.greenColor.withOpacity(0.10),
                ),
              ],
            )
          ],
          20.toHeight,
          const TextSkeleton(
            height: 18,
            width: double.infinity,
          ),
          8.toHeight,
          TextSkeleton(
            height: 18,
            width: context.width / 1.5,
          ),
          12.toHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextSkeleton(
                height: 16,
                width: 60,
                color: context.dProvider.primary10,
              ),
              const TextSkeleton(
                height: 16,
                width: 100,
              ),
            ],
          ),
        ],
      ).hp20,
    );
  }
}
