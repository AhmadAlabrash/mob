import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/utils/components/text_skeleton.dart';

class ProfileDetailsSkeleton extends StatelessWidget {
  const ProfileDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.dProvider.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: CircleAvatar(
                      radius: 35,
                      backgroundColor: context.dProvider.black8,
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
                        Container(
                          height: 16,
                          width: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: context.dProvider.black8,
                          ),
                        ),
                        8.toHeight,
                        const TextSkeleton(height: 16, width: 100),
                        6.toHeight,
                        const TextSkeleton(height: 14, width: 120),
                        8.toHeight,
                        Container(
                          height: 20,
                          width: 60,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: context.dProvider.black8,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 46,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextSkeleton(
                    height: 16,
                    width: context.width / 3,
                  ),
                  Container(
                    height: 30,
                    width: 60,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: context.dProvider.black8,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ],
              ),
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 46,
              ),
              const TextSkeleton(height: 16, width: 80),
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 46,
              ),
              TextSkeleton(height: 14, width: context.width / 2),
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 46,
              ),
              TextSkeleton(height: 14, width: context.width / 1.5),
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 46,
              ),
              const TextSkeleton(height: 16, width: 80),
              12.toHeight,
              TextSkeleton(height: 14, width: context.width - 80),
              8.toHeight,
              TextSkeleton(height: 14, width: context.width / 1.3),
              8.toHeight,
              TextSkeleton(height: 14, width: context.width / 1.6),
              8.toHeight,
            ],
          ),
        ),
        20.toHeight,
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.dProvider.whiteColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...[1, 2, 3, 6].map((e) => Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 40,
                          backgroundColor: context.dProvider.black8,
                        ),
                        title: const TextSkeleton(height: 16, width: 80),
                        subtitle: const TextSkeleton(height: 14, width: 80),
                      ),
                      Divider(
                        color: context.dProvider.black8,
                        thickness: 2,
                        height: 46,
                      )
                    ],
                  )),
            ],
          ),
        )
      ],
    ).shim;
  }
}
