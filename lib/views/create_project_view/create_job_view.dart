import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';
import 'package:xilancer/views/create_project_view/components/create_job_timeline.dart';
import 'package:xilancer/views/create_project_view/components/job_skill_budget.dart';

import '../../services/job_details_service.dart';
import '../../utils/components/custom_future_widget.dart';
import 'components/job_intro.dart';

class CreateJobView extends StatelessWidget {
  static const routeName = 'create_project_view';
  final jobId;
  const CreateJobView({super.key, this.jobId});
  @override
  Widget build(BuildContext context) {
    final cjm = CreateJobViewModel.instance;
    final jdProvider = Provider.of<JobDetailsService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: NavigationPopIcon(
          onTap: () {
            cjm.goBack(context);
          },
        ),
        title: Text(LocalKeys.postAJob),
      ),
      body: WillPopScope(
        onWillPop: () async {
          cjm.goBack(context);
          return false;
        },
        child: CustomFutureWidget(
          function: jdProvider.shouldAutoFetch(jobId) && jobId != null
              ? jdProvider.fetchDetails(jobId: jobId)
              : null,
          shimmer: const CustomPreloader(),
          child: Builder(builder: (context) {
            cjm.setJob(context);
            return Column(
              children: [
                CreateJobTimeline(cjm: cjm),
                Expanded(
                  child: Container(
                    child: ValueListenableBuilder(
                      valueListenable: cjm.currentIndex,
                      builder: (context, value, child) =>
                          ValueListenableBuilder(
                        valueListenable: cjm.heights,
                        builder: (context, heights, child) => PageView(
                          controller: cjm.pageController,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            JobIntro(cjm: cjm),
                            const JobSkillBudget(),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
