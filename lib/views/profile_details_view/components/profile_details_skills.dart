import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/services/profile_details_service.dart';
import 'package:xilancer/utils/components/custom_button.dart';

import '../../../view_models/profile_details_view_model/profile_details_view_model.dart';
import 'skill_chip.dart';

class ProfileDetailsSkills extends StatelessWidget {
  final ProfileDetailsService pd;
  const ProfileDetailsSkills({super.key, required this.pd});

  @override
  Widget build(BuildContext context) {
    final skills = (pd.profileDetails.skills ?? "").isEmpty
        ? []
        : (pd.profileDetails.skills ?? "").split(", ").toList();
    final pdm = ProfileDetailsViewModel.instance;
    return skills.isEmpty
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.dProvider.whiteColor,
            ),
            child: ValueListenableBuilder(
              valueListenable: pdm.skillEditing,
              builder: (context, skEditing, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocalKeys.skills, style: context.titleMedium?.bold6),
                      ValueListenableBuilder(
                        valueListenable: pdm.viewAsClient,
                        builder: (context, value, child) => value
                            ? const SizedBox()
                            : InkWell(
                                onTap: () {
                                  pdm.skillEditing.value =
                                      !pdm.skillEditing.value;
                                },
                                child: skEditing
                                    ? const Icon(Icons.close)
                                    : SvgAssets.edit2.toSVGSized(24,
                                        color: context.dProvider.black3)),
                      )
                    ],
                  ).hp20,
                  Divider(
                    color: context.dProvider.black8,
                    thickness: 2,
                    height: 36,
                  ),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      ...skills
                          .map((e) => SkillChip(
                                skill: e,
                              ))
                          .toList(),
                    ],
                  ).hp20,
                  if (skEditing)
                    Divider(
                      color: context.dProvider.black8,
                      thickness: 2,
                      height: 36,
                    ),
                  if (skEditing)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomButton(
                            width: (context.width - 100) / 2,
                            onPressed: () {},
                            btText: LocalKeys.updateSkill,
                            isLoading: false)
                      ],
                    ).hp20,
                ],
              ),
            ),
          );
  }
}
