import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/job_list_service.dart.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/empty_widget.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/utils/components/scrolling_preloader.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';
import 'package:xilancer/view_models/home_view_model/home_view_model.dart';
import 'package:xilancer/view_models/my_jobs_view_model/my_jobs_view_model.dart';
import 'package:xilancer/views/create_project_view/create_job_view.dart';

import '../../../utils/components/custom_preloader.dart';
import '../home_view/components/job_card_skeleton.dart';
import 'components/job_card.dart';

class MyJobsView extends StatelessWidget {
  static const routeName = "my_jobs_view";
  const MyJobsView({super.key});

  @override
  Widget build(BuildContext context) {
    final mjm = MyJobsViewModel.instance;
    mjm.scrollController.addListener(() {
      mjm.tryToLoadMore(context);
    });
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
        title: Text(LocalKeys.myJobs),
        actions: [
          ElevatedButton.icon(
              onPressed: () {
                CreateJobViewModel.dispose;
                context.toPage(const CreateJobView());
              },
              icon: const Icon(Icons.add_rounded),
              label: Text(LocalKeys.createJob)),
          16.toWidth,
        ],
      ),
      body: Consumer<JobListService>(builder: (context, jl, child) {
        return CustomRefreshIndicator(
          onRefresh: () async {
            await jl.fetchJobList();
          },
          child: CustomFutureWidget(
              function:
                  jl.shouldAutoFetch ? jl.fetchJobList(refreshing: true) : null,
              shimmer: ListView.separated(
                      padding: const EdgeInsets.all(20),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return const JobCardSkeleton(fromDetails: false);
                      },
                      separatorBuilder: (context, index) => 16.toHeight,
                      itemCount: 20)
                  .shim,
              child: jl.jobList?.isEmpty ?? true == true
                  ? EmptyWidget(title: LocalKeys.noJobFound)
                  : Scrollbar(
                      controller: mjm.scrollController,
                      child: ListView.separated(
                          padding: const EdgeInsets.all(20),
                          physics: const AlwaysScrollableScrollPhysics(),
                          controller: mjm.scrollController,
                          itemBuilder: (context, index) {
                            if ((jl.nextPage != null && !jl.nexLoadingFailed) &&
                                index == jl.jobList!.length) {
                              return ScrollPreloader(
                                  loading: jl.nextPageLoading);
                            }

                            final jobItem = jl.jobList![index];
                            return JobCard(
                              id: jobItem.id,
                              title: jobItem.title,
                              createDate: jobItem.createdAt,
                              expertise: jobItem.level.toString().capitalize,
                              price: jobItem.budget,
                              priceType: jobItem.type.toString().capitalize,
                              proposalCount: jobItem.jobProposalCount ?? 0,
                              jobStatus: jobItem.onOff.toString() == "1",
                            );
                          },
                          separatorBuilder: (context, index) => 16.toHeight,
                          itemCount: jl.jobList!.length +
                              (jl.nextPage != null && !jl.nexLoadingFailed
                                  ? 1
                                  : 0)),
                    )),
        );
      }),
    );
  }
}
