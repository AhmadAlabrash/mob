import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/job_details_service.dart';
import 'package:xilancer/themes/default_themes.dart';
import 'package:xilancer/utils/components/alerts.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';
import 'package:xilancer/views/create_project_view/create_job_view.dart';

import '../../../helper/constant_helper.dart';
import '../../../helper/svg_assets.dart';
import '../../../view_models/fix_price_job_details_view_model/fix_price_job_details_view_model.dart';

class FixedPriceJobDetailsButtons extends StatelessWidget {
  final id;
  final jobStatus;
  const FixedPriceJobDetailsButtons({
    super.key,
    required this.id,
    required this.jobStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: OutlinedButton.icon(
              onPressed: () {
                FixPriceJobDetailsViewModel.instance
                    .tryClosingJob(context, id: id, jobStatus: jobStatus);
              },
              style: DefaultThemes()
                  .outlinedButtonTheme(dProvider,
                      foregroundColor: jobStatus == true
                          ? context.dProvider.warningColor
                          : context.dProvider.greenColor,
                      color: jobStatus == true
                          ? context.dProvider.warningColor
                          : context.dProvider.greenColor)
                  ?.style,
              icon: Icon(
                  jobStatus == true ? Icons.close_rounded : Icons.done_rounded,
                  color: jobStatus == true
                      ? context.dProvider.warningColor
                      : context.dProvider.greenColor),
              label: Text(
                  jobStatus == true ? LocalKeys.closeJob : LocalKeys.openJob)),
        ),
        12.toWidth,
        Expanded(
          flex: 1,
          child: ElevatedButton.icon(
              onPressed: () {
                CreateJobViewModel.dispose;
                CreateJobViewModel.instance.setJob(context);
                context.toPage(CreateJobView(
                  jobId: id,
                ));
              },
              icon: SvgAssets.edit2
                  .toSVGSized(24, color: context.dProvider.whiteColor),
              label: Text(LocalKeys.editJob)),
        ),
      ],
    );
  }
}
