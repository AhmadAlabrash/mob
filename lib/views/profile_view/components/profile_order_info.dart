import 'package:flutter/material.dart';
import '/helper/extension/context_extension.dart';
import '/helper/local_keys.g.dart';
import '/utils/components/empty_spacer_helper.dart';

import 'profile_order_info_block.dart';

class ProfileOrderInfo extends StatelessWidget {
  const ProfileOrderInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: context.width / 4,
          child:
              ProfileOrderInfoBlock(value: "21", title: LocalKeys.assignOrder),
        ),
        EmptySpaceHelper.emptyWidth(16),
        SizedBox(
          width: context.width / 4,
          child:
              ProfileOrderInfoBlock(value: "1650", title: LocalKeys.totalOrder),
        ),
        EmptySpaceHelper.emptyWidth(16),
        SizedBox(
          width: context.width / 4,
          child:
              ProfileOrderInfoBlock(value: "21", title: LocalKeys.pendingOrder),
        ),
      ],
    );
  }
}
