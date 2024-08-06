import 'package:flutter/material.dart';
import '/helper/extension/context_extension.dart';
import '/helper/extension/string_extension.dart';
import '/helper/local_keys.g.dart';
import '/utils/components/empty_spacer_helper.dart';

import '../../../helper/svg_assets.dart';
import 'profile_info_painter.dart';
import 'profile_order_info.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomPaint(
          painter: ProfileInfoPainter(color: context.dProvider.primaryColor),
          child: SizedBox(
            height: 300,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Column(
                    children: [
                      Text(
                        "Shahin Boss",
                        style: context.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      EmptySpaceHelper.emptyHeight(6),
                      const Text(
                        "shahinboss@marride.com",
                      ),
                      EmptySpaceHelper.emptyHeight(8),
                      TextButton.icon(
                          onPressed: () {},
                          icon: SvgAssets.userEdit.toSVGSized(16,
                              color: context.dProvider.primaryColor),
                          label: Text(
                            LocalKeys.editProfile,
                            style: const TextStyle().bold,
                          )),
                      EmptySpaceHelper.emptyHeight(16),
                      const ProfileOrderInfo()
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
