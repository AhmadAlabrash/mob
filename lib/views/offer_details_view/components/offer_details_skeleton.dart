import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';

import '../../../utils/components/text_skeleton.dart';

class OfferDetailsSkeleton extends StatelessWidget {
  const OfferDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.dProvider.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextSkeleton(height: 14, width: 60).hp20,
                10.toHeight,
                Wrap(
                  runSpacing: 12,
                  spacing: 12,
                  children: [
                    Container(
                      height: 18,
                      width: 80,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: context.dProvider.black8,
                      ),
                    ),
                    Container(
                      height: 18,
                      width: 120,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: context.dProvider.black8,
                      ),
                    ),
                  ],
                ).hp20,
                10.toHeight,
                const TextSkeleton(
                  height: 14,
                  width: 60,
                ).hp20,
                Divider(
                  color: context.dProvider.black8,
                  thickness: 2,
                  height: 36,
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          TextSkeleton(
                            height: 14,
                            width: 60,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          TextSkeleton(
                            height: 16,
                            width: context.width / 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ).hp20,
                Divider(
                  color: context.dProvider.black8,
                  thickness: 2,
                  height: 36,
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          TextSkeleton(
                            height: 14,
                            width: 60,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          TextSkeleton(
                            height: 16,
                            width: context.width / 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ).hp20,
                Divider(
                  color: context.dProvider.black8,
                  thickness: 2,
                  height: 36,
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          TextSkeleton(
                            height: 14,
                            width: 100,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: context.dProvider.black8,
                          ),
                          8.toWidth,
                          const TextSkeleton(
                            height: 16,
                            width: 80,
                          ),
                        ],
                      ),
                    ),
                  ],
                ).hp20,
              ],
            ),
          ),
          20.toHeight,
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.dProvider.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextSkeleton(height: 16, width: 120).hp20,
                Divider(
                  color: context.dProvider.black8,
                  thickness: 2,
                  height: 36,
                ),
                const TextSkeleton(
                  height: 12,
                  width: double.infinity,
                ).hp20,
                6.toHeight,
                TextSkeleton(
                  height: 12,
                  width: context.width - 100,
                ).hp20,
                6.toHeight,
                const TextSkeleton(height: 12, width: 120).hp20,
              ],
            ),
          ),
          20.toHeight,
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.dProvider.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TextSkeleton(height: 16, width: 120).hp20,
                ...[0, 2].map((_) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: context.dProvider.black8,
                        thickness: 2,
                        height: 36,
                      ),
                      TextSkeleton(
                        height: 14,
                        width: context.width / 2,
                      ).hp20,
                      6.toHeight,
                      Wrap(
                        runSpacing: 12,
                        spacing: 12,
                        children: [
                          Container(
                            height: 18,
                            width: 40,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: context.dProvider.primaryColor
                                  .withOpacity(.10),
                            ),
                          ),
                          Container(
                            height: 18,
                            width: 60,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: context.dProvider.yellowColor
                                  .withOpacity(.10),
                            ),
                          ),
                        ],
                      ).hp20,
                      6.toHeight,
                      Row(
                        children: [
                          TextSkeleton(
                            height: 12,
                            width: 46,
                            color:
                                context.dProvider.primaryColor.withOpacity(.10),
                          ),
                          12.toWidth,
                          const TextSkeleton(
                            height: 12,
                            width: 120,
                          ),
                        ],
                      ).hp20,
                      12.toHeight,
                      TextSkeleton(height: 12, width: context.width - 100).hp20,
                      6.toHeight,
                      const TextSkeleton(height: 12, width: 120).hp20,
                    ],
                  );
                })
              ],
            ),
          ),
        ],
      ),
    ).shim;
  }
}
