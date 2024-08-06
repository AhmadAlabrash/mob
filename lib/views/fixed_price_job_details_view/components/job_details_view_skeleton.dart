import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/utils/components/text_skeleton.dart';
import 'package:xilancer/views/home_view/components/job_card_skeleton.dart';

class JobDetailsSkeleton extends StatelessWidget {
  const JobDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.dProvider.whiteColor,
            ),
            child: Column(
              children: [
                const JobCardSkeleton(fromDetails: true),
                20.toHeight,
                Container(
                  height: 44,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: context.dProvider.black9,
                      )),
                ).hp20,
                8.toHeight,
                Container(
                  height: 44,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.dProvider.black9,
                  ),
                ).hp20,
                8.toHeight,
                Container(
                  height: 44,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: context.dProvider.primary10,
                  ),
                ).hp20,
              ],
            )),
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
              const TextSkeleton(height: 16, width: 100).hp20,
              20.toHeight,
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: context.dProvider.black8,
                  ),
                  const TextSkeleton(height: 16, width: 60)
                ],
              ).hp20,
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 20,
              ),
              6.toHeight,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextSkeleton(height: 14, width: 80),
                  TextSkeleton(height: 16, width: 120)
                ],
              ).hp20,
              6.toHeight,
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 20,
              ),
              6.toHeight,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextSkeleton(height: 14, width: 100),
                  TextSkeleton(height: 16, width: 60)
                ],
              ).hp20,
              6.toHeight,
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 20,
              ),
            ],
          ),
        )
      ],
    ).shim;
  }
}
