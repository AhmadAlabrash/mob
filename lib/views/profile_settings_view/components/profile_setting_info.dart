import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/profile_info_service.dart';
import 'profile_info_avatar.dart';
import '/helper/extension/context_extension.dart';

class ProfileSettingInfo extends StatelessWidget {
  const ProfileSettingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileInfoService>(builder: (context, pi, child) {
      return SafeArea(
        child: CustomPaint(
            child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              color: context.dProvider.whiteColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                child: Column(
                  children: [
                    const ProfileInfoAvatar(),
                    Text(
                      (pi.profileInfoModel.data?.firstName ??
                              LocalKeys.freelancer) +
                          (" ${pi.profileInfoModel.data?.lastName}"),
                      style: context.titleMedium?.bold6,
                    ),
                    4.toHeight,
                    Text(
                      pi.profileInfoModel.data?.email ?? "",
                      style: context.titleSmall
                          ?.copyWith(color: context.dProvider.black5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )),
      );
    });
  }
}
