import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import '../../../utils/components/text_skeleton.dart';

class NotificationListSkeleton extends StatelessWidget {
  const NotificationListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 20),
            itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(20),
                  color: context.dProvider.whiteColor,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: context.dProvider.black8,
                      ),
                      12.toWidth,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextSkeleton(
                            width: context.width / 1.7,
                            height: 16,
                          ),
                          8.toHeight,
                          TextSkeleton(
                            width: context.width / 3,
                            height: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => 4.toHeight,
            itemCount: 10)
        .shim;
  }
}
