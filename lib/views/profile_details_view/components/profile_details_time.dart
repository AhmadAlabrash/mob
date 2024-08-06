import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';

import '../../../services/profile_details_service.dart';

class ProfileDetailsTime extends StatelessWidget {
  final ProfileDetailsService pd;
  const ProfileDetailsTime({super.key, required this.pd});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgAssets.clock.toSVGSized(20),
        8.toWidth,
        Text(pd.profileDetails.timeZone!,
            style:
                context.titleSmall?.copyWith(color: context.dProvider.black5)),
        Text(" (${LocalKeys.localTime})",
            style:
                context.titleSmall?.copyWith(color: context.dProvider.black5))
      ],
    );
  }
}
