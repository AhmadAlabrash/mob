import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

import '/helper/extension/context_extension.dart';
import '/helper/extension/string_extension.dart';
import '../../helper/svg_assets.dart';

class Notifications extends StatelessWidget {
  const Notifications({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: badges.Badge(
        showBadge: true,
        badgeContent: Text(
          '12',
          style: const TextStyle().copyWith(
              color: context.dProvider.whiteColor, fontWeight: FontWeight.w600),
        ),
        child: Container(
          height: 40,
          width: 40,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: context.dProvider.black8),
            shape: BoxShape.circle,
          ),
          child: SvgAssets.notificationBell.toSVG,
        ),
      ),
    );
  }
}
