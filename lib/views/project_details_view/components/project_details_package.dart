import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/views/project_details_view/components/project_details_package_charges.dart';

import '../../../view_models/project_details_view_model/project_details_view_model.dart';
import 'project_details_package_delivery_time.dart';
import 'projects_details_package_extra_field.dart';
import 'package_name.dart';
import 'project_details_package_revisions.dart';
import 'packages_list.dart';

class ProjectDetailsPackages extends StatelessWidget {
  final projectId;
  const ProjectDetailsPackages({super.key, this.projectId});

  @override
  Widget build(BuildContext context) {
    final pdm = ProjectDetailsViewModel.instance;
    return FutureBuilder(
        future: pdm.initPackage(context, projectId),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PackagesList(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const PackageName(),
                  const ProjectDetailsPackageRevisions(),
                  const ProjectDetailsPackageDeliveryTime(),
                  ValueListenableBuilder(
                      valueListenable: pdm.packageIndex,
                      builder: (context, ind, child) {
                        int index = 0;
                        debugPrint(ind.toString().toString());
                        return Column(
                          children: pdm.packages[ind].extraFields
                              .map((e) => ProjectDetailsPackageExtraField(
                                    pdm: pdm,
                                    index: index++,
                                  ))
                              .toList(),
                        );
                      }),
                  Divider(
                    color: context.dProvider.black8,
                    height: 1,
                  ),
                  ValueListenableBuilder(
                    valueListenable: pdm.packageIndex,
                    builder: (context, index, child) =>
                        ProjectDetailsPackageChanges(
                      regularCharge:
                          pdm.packages[index].regularPrice.toStringAsFixed(2),
                      discountCharge: pdm.packages[index].discountPrice ?? 0,
                      projectId: projectId,
                    ),
                  ),
                ],
              ),
            ],
          );
        });
  }
}
