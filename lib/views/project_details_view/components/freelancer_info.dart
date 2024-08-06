import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/views/project_details_view/components/freelancer_info_location.dart';
import 'package:xilancer/views/project_details_view/components/freelancer_info_time.dart';
import 'package:xilancer/views/project_details_view/components/freelancer_name_infos.dart';

import '../../../services/project_details_service.dart';

class FreelancerInfo extends StatelessWidget {
  final projectId;

  const FreelancerInfo({super.key, this.projectId});

  @override
  Widget build(BuildContext context) {
    final pdProvider =
        Provider.of<ProjectDetailsService>(context, listen: false);
    final userDetails = pdProvider.projectDetailsModel[projectId.toString()]
        ?.projectDetails?.projectCreator;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FreelancerNameInfos(userDetails: userDetails, projectId: projectId),
        ],
      ),
    );
  }

  infos(BuildContext context, title, desc) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          Expanded(
              child: Text(
            title,
            style: context.titleSmall?.black5,
          )),
          Expanded(
              child: Text(
            desc,
            textAlign: TextAlign.end,
            style: context.titleSmall?.bold6,
          ))
        ],
      ).hp20,
    );
  }
}
