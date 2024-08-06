import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/svg_assets.dart';

import '../../../services/profile_details_service.dart';

class ProfileDetailsLocation extends StatelessWidget {
  final ProfileDetailsService pd;
  const ProfileDetailsLocation({super.key, required this.pd});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: SvgAssets.location.toSVG,
        ),
        8.toWidth,
        Expanded(
            flex: 10,
            child: Text(
                "${"${pd.profileDetails.user?.userState?.state?.toString() ?? ""}, "} ${(pd.profileDetails.user?.userCountry?.country?.toString() ?? "")}",
                style: context.titleSmall
                    ?.copyWith(color: context.dProvider.black5))),
      ],
    );
  }
}
