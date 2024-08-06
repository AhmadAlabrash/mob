import 'package:flutter/material.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';
import '../../../helper/local_keys.g.dart';
import '../../../utils/components/empty_spacer_helper.dart';
import '/helper/extension/context_extension.dart';
import 'create_job_title_timeline.dart';

class CreateJobTimeline extends StatelessWidget {
  const CreateJobTimeline({
    super.key,
    required this.cjm,
  });

  final CreateJobViewModel cjm;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
        decoration: BoxDecoration(
          color: context.dProvider.primary05,
          border: Border(
            top: BorderSide(color: context.dProvider.black8, width: 2),
            bottom: BorderSide(color: context.dProvider.black8, width: 2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CreateJobTitleTimeline(),
            EmptySpaceHelper.emptyHeight(16),
          ],
        ));
  }
}
