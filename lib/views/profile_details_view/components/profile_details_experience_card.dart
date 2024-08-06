import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';

import '../../../view_models/profile_details_view_model/profile_details_view_model.dart';

class ProfileDetailsExperienceCard extends StatelessWidget {
  final title;
  final subtitle;
  final startDate;
  final endDate;
  final location;
  const ProfileDetailsExperienceCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.startDate,
    required this.endDate,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final pdm = ProfileDetailsViewModel.instance;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: pdm.viewAsClient,
            builder: (context, value, child) => ListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              title: Text(
                title,
                style: context.titleMedium?.copyWith().bold6,
              ),
              subtitle: Text(subtitle),
              trailing: value ? null : SvgAssets.edit.toSVG,
            ),
          ),
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
          ),
          12.toHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgAssets.calender.toSVG,
                    8.toWidth,
                    Text(LocalKeys.duration, style: context.titleSmall)
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 6,
                child: RichText(
                  text: TextSpan(
                    text: DateFormat("dd-mm-yyyy").format(startDate),
                    style: context.titleSmall
                        ?.copyWith(color: context.dProvider.black2),
                    children: [
                      TextSpan(
                          text: ' - ',
                          style: context.titleSmall
                              ?.copyWith(color: context.dProvider.black2)),
                      TextSpan(
                          text: endDate == null
                              ? LocalKeys.currentPosition
                              : DateFormat("dd-mm-yyyy").format(endDate),
                          style: context.titleSmall?.copyWith(
                              color: endDate is DateTime
                                  ? context.dProvider.black2
                                  : context.dProvider.primaryColor)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          16.toHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgAssets.location.toSVG,
                    8.toWidth,
                    Text(LocalKeys.location, style: context.titleSmall)
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: SizedBox(),
              ),
              Expanded(
                flex: 6,
                child: Text(location, style: context.titleSmall),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
