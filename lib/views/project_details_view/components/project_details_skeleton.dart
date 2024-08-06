import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';

import '../../../utils/components/text_skeleton.dart';

class ProjectDetailsSkeleton extends StatelessWidget {
  const ProjectDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
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
              const TextSkeleton(
                height: 12,
                width: double.infinity,
              ),
              4.toHeight,
              TextSkeleton(
                height: 12,
                width: context.width - 60,
              ),
              4.toHeight,
              const TextSkeleton(
                height: 12,
                width: double.infinity,
              ),
              4.toHeight,
              TextSkeleton(
                height: 12,
                width: context.width / 1.5,
              ),
            ],
          ).hp20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.dProvider.whiteColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 4,
                child: CircleAvatar(
                  radius: 30,
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    8.toHeight,
                    const TextSkeleton(
                      height: 18,
                      width: 150,
                    ),
                    8.toHeight,
                    Wrap(
                      runSpacing: 12,
                      spacing: 12,
                      children: [
                        const TextSkeleton(
                          height: 16,
                          width: 80,
                        ),
                        Container(
                          height: 16,
                          width: 40,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                context.dProvider.yellowColor.withOpacity(0.10),
                          ),
                        ),
                        Container(
                          height: 16,
                          width: 80,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:
                                context.dProvider.greenColor.withOpacity(0.10),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    ).shim;
  }
}
