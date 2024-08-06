import 'package:flutter/material.dart';

import '/utils/components/skeleton_widget.dart';
import '/helper/extension/context_extension.dart';
import '/helper/extension/widget_extension.dart';
import '../../../utils/components/empty_spacer_helper.dart';

class ChatTileShimmer extends StatelessWidget {
  const ChatTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: context.dProvider.whiteColor,
      child: ListView.separated(
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: context.dProvider.black8,
                          shape: BoxShape.circle),
                    ),
                    EmptySpaceHelper.emptyWidth(12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShimmerWidget(
                              color: context.dProvider.black8,
                              height: 20,
                              width: context.width / 3,
                            ),
                            EmptySpaceHelper.emptyWidth(context.width / 5.6),
                            ShimmerWidget(
                              color: context.dProvider.black8,
                              height: 16,
                              width: context.width / 5,
                            )
                          ],
                        ),
                        EmptySpaceHelper.emptyHeight(8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ShimmerWidget(
                              color: context.dProvider.black8,
                              height: 18,
                              width: context.width / 2,
                            ),
                            EmptySpaceHelper.emptyWidth(context.width / 8.3),
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: context.dProvider.black8,
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                );
              },
              separatorBuilder: (context, index) => Divider(
                    color: context.dProvider.black8,
                    height: 24,
                    thickness: 2,
                  ),
              itemCount: 4)
          .shim,
    );
  }
}
