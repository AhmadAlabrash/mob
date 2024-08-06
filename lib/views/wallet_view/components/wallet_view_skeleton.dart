import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/utils/components/text_skeleton.dart';

class WalletViewSkeleton extends StatelessWidget {
  const WalletViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: context.dProvider.whiteColor,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            children: [
              TextSkeleton(
                height: 20,
                width: context.width / 3,
              ),
            ],
          ),
        ),
        20.toHeight,
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: context.dProvider.whiteColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: Row(
            children: [
              TextSkeleton(
                height: 16,
                width: context.width / 3.5,
              ),
            ],
          ),
        ),
        2.toHeight,
        ...[1, 2, 1, 1, 1, 1]
            .map((e) => Container(
                  margin: const EdgeInsets.only(bottom: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  color: context.dProvider.whiteColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextSkeleton(height: 18, width: 60),
                      8.toHeight,
                      Row(
                        children: [
                          const TextSkeleton(height: 14, width: 120),
                          4.toWidth,
                          const TextSkeleton(height: 14, width: 40)
                        ],
                      ),
                      8.toHeight,
                      Row(
                        children: [
                          const TextSkeleton(height: 14, width: 150),
                          4.toWidth,
                          const TextSkeleton(height: 14, width: 60),
                        ],
                      ),
                      8.toHeight,
                      const TextSkeleton(height: 14, width: 100),
                    ],
                  ),
                ))
            .toList(),
      ],
    ).shim;
  }
}
