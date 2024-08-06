import 'package:flutter/material.dart';
import '/helper/local_keys.g.dart';
import '/utils/components/empty_spacer_helper.dart';
import '/utils/components/notifications.dart';

class WalletAppBar extends StatelessWidget {
  const WalletAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        LocalKeys.myWallet,
      ),
      actions: [const Notifications(), EmptySpaceHelper.emptyWidth(24)],
    );
  }
}
