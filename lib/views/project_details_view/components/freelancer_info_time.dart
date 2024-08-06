import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';

class FreelancerInfoTime extends StatelessWidget {
  const FreelancerInfoTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgAssets.clock.toSVGSized(20),
        8.toWidth,
        Text(DateFormat("hh:mm a").format(DateTime.now()),
            style:
                context.titleSmall?.copyWith(color: context.dProvider.black5)),
        Text(" (${LocalKeys.localTime})",
            style:
                context.titleSmall?.copyWith(color: context.dProvider.black5))
      ],
    );
  }
}
