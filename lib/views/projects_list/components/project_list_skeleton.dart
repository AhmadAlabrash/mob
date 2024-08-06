import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';

import 'project_card_skeleton.dart';

class ProjectListSkeleton extends StatelessWidget {
  const ProjectListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
            10,
            (index) => Column(
                  children: [
                    const ProjectCardSkeleton(),
                    16.toHeight,
                  ],
                )).toList()
      ],
    ).shim;
  }
}
