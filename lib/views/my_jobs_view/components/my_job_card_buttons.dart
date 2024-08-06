import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/utils/components/alerts.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';
import 'package:xilancer/view_models/fix_price_job_details_view_model/fix_price_job_details_view_model.dart';

import '../../create_project_view/create_job_view.dart';
import '../../fixed_price_job_details_view/fixed_price_job_details_view.dart';

class MyJobCardButtons extends StatelessWidget {
  final id;
  final title;
  final jobStatus;
  const MyJobCardButtons({
    super.key,
    this.id,
    this.title,
    this.jobStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(6), bottomRight: Radius.circular(6)),
        color: context.dProvider.primary05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    FixPriceJobDetailsViewModel.dispose;
                    debugPrint(id.toString());
                    context.toNamed(FixedPriceJobDetailsView.routeName,
                        arguments: [id, title]);
                  },
                  child: Text(LocalKeys.viewJob),
                ),
              ),
              12.toWidth,
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text(
                          jobStatus ? LocalKeys.closeJob : LocalKeys.openJob),
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 100));
                        FixPriceJobDetailsViewModel.instance.tryClosingJob(
                            context,
                            id: id,
                            jobStatus: jobStatus);
                      },
                    ),
                    PopupMenuItem(
                      child: Text(LocalKeys.editJob),
                      onTap: () {
                        CreateJobViewModel.dispose;
                        CreateJobViewModel.instance.setJob(context);
                        context.toPage(CreateJobView(
                          jobId: id,
                        ));
                      },
                    ),
                  ];
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
