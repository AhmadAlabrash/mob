import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/services/profile_details_service.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_education_card.dart';

import '../../../helper/local_keys.g.dart';
import '../../../view_models/profile_details_view_model/profile_details_view_model.dart';

class ProfileDetailsEducation extends StatelessWidget {
  final ProfileDetailsService pd;
  const ProfileDetailsEducation({super.key, required this.pd});

  @override
  Widget build(BuildContext context) {
    final educations = pd.profileDetails.educations ?? [];
    int index = 0;
    final pdm = ProfileDetailsViewModel.instance;
    return educations.isEmpty
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.dProvider.whiteColor,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocalKeys.education,
                        style: context.titleMedium?.bold6),
                    ValueListenableBuilder(
                      valueListenable: pdm.viewAsClient,
                      builder: (context, value, child) => value
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {},
                              child: Icon(
                                Icons.add_circle_outline_rounded,
                                color: context.dProvider.black3,
                              )),
                    )
                  ],
                ).hp20,
                Divider(
                  color: context.dProvider.black8,
                  thickness: 2,
                  height: 36,
                ),
                ...educations
                    .map((e) => Column(
                          children: [
                            ProfileDetailsEducationCard(
                                title: e.subject,
                                subtitle: e.institution,
                                startDate: e.startDate ?? DateTime.now(),
                                endDate: e.endDate,
                                location: e.degree),
                            if (++index != educations.length)
                              Divider(
                                color: context.dProvider.black8,
                                thickness: 2,
                                height: 36,
                              )
                          ],
                        ))
                    .toList()
              ],
            ),
          );
  }
}
