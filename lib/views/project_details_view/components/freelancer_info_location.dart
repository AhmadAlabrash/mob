import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/svg_assets.dart';

import '../../../services/profile_details_service.dart';

class FreelancerInfoLocation extends StatelessWidget {
  final String? country;
  final String? state;
  const FreelancerInfoLocation({
    super.key,
    required this.country,
    this.state,
  });

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
                "${"${state.toString() ?? ""}, "} ${(country.toString() ?? "")}",
                style: context.titleSmall
                    ?.copyWith(color: context.dProvider.black5))),
      ],
    );
  }
}
