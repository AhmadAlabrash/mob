import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/profile_details_service.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_location.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_time.dart';

import '../../../helper/local_keys.g.dart';
import 'profile_details_price.dart';
import 'profile_name_infos.dart';

class ProfileDetailsBasicInfo extends StatelessWidget {
  final bool userActiveStatus;
  const ProfileDetailsBasicInfo({super.key, required this.userActiveStatus});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileDetailsService>(builder: (context, pd, child) {
      final user = pd.profileDetails.user;
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileNameInfos(
              userActiveStatus: userActiveStatus,
            ),
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 36,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocalKeys.availableForWork,
                  style: context.titleMedium?.bold6,
                ),
                Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    value: user?.checkWorkAvailability.toString() == "1",
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 36,
            ),
            ProfileDetailsPrice(pd: pd),
            Divider(
              color: context.dProvider.black8,
              thickness: 2,
              height: 36,
            ),
            ProfileDetailsLocation(
              pd: pd,
            ),
            if (pd.profileDetails.timeZone != null) ...[
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 36,
              ),
              ProfileDetailsTime(pd: pd)
            ],
            if (user?.userIntroduction?.description != null) ...[
              Divider(
                color: context.dProvider.black8,
                thickness: 2,
                height: 36,
              ),
              Text(
                LocalKeys.aboutMe,
                style: context.titleMedium?.bold6,
              ),
              8.toHeight,
              Text(user!.userIntroduction!.description!,
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.black5))
            ]
          ],
        ),
      );
    });
  }
}
