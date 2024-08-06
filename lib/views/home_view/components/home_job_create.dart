import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/views/create_project_view/create_job_view.dart';

import '../../../view_models/create_job_view_model/create_job_view_model.dart';

class HomeJobCreate extends StatelessWidget {
  const HomeJobCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.dProvider.whiteColor,
      ),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocalKeys.needAnythingSpecific,
                    style: context.titleLarge?.bold6,
                  ),
                  8.toHeight,
                  Text(
                    LocalKeys.postJobs,
                    style: context.titleMedium,
                  ),
                ],
              )),
          12.toWidth,
          ElevatedButton(
              onPressed: () {
                CreateJobViewModel.dispose;
                context.toPage(const CreateJobView());
              },
              child: Text(LocalKeys.postAJob)),
        ],
      ),
    );
  }
}
