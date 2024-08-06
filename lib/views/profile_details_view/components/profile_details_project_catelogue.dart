import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/profile_details_service.dart';
import 'package:xilancer/models/project_list_model.dart' as pl;
import 'package:xilancer/view_models/profile_details_view_model/profile_details_view_model.dart';
import 'package:xilancer/views/projects_list/components/project_card.dart';

class ProfileViewProjectCatalogue extends StatelessWidget {
  final ProfileDetailsService pd;
  const ProfileViewProjectCatalogue({super.key, required this.pd});

  @override
  Widget build(BuildContext context) {
    final projects = pd.profileDetails.projects ?? [];
    final projectsPath = pd.profileDetails.projectPath ?? '';
    int index = 0;
    final pdm = ProfileDetailsViewModel.instance;
    return projects.isEmpty
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.dProvider.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocalKeys.projectCatalogues,
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
                ...projects
                    .map((e) => Column(
                          children: [
                            ProjectCard(project: e, projectsPath: projectsPath),
                            if (++index != projects.length) ...[
                              Divider(
                                color: context.dProvider.black8,
                                thickness: 2,
                              ),
                              8.toHeight
                            ]
                          ],
                        ))
                    .toList()
              ],
            ),
          );
  }
}
