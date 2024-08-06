import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/project_list_service.dart.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/empty_widget.dart';
import 'package:xilancer/views/projects_list/components/project_card.dart';

import '../../utils/components/scrolling_preloader.dart';
import '../../view_models/home_drawer_view_model/home_drawer_view_model.dart';
import '../../view_models/home_view_model/home_view_model.dart';
import '../home_view/components/home_job_create.dart';
import 'components/project_list_skeleton.dart';

class ProjectsList extends StatelessWidget {
  const ProjectsList({super.key});

  @override
  Widget build(BuildContext context) {
    final hvm = HomeViewModel.instance;
    hvm.scrollController.addListener(() {
      hvm.tryToLoadMore(context);
    });
    return CustomRefreshIndicator(
      onRefresh: () async {
        await Provider.of<ProjectListService>(context, listen: false)
            .fetchProjectList(refreshing: true);
      },
      child: Consumer<ProjectListService>(builder: (context, pl, child) {
        final hdm = HomeDrawerViewModel.instance;
        return FutureBuilder(
          future: pl.shouldAutoFetch ? pl.fetchProjectList() : null,
          builder: (context, snapshot) {
            return ValueListenableBuilder(
                valueListenable: hdm.isLoading,
                builder: (context, loading, child) {
                  return ListView.separated(
                      controller: hvm.scrollController,
                      physics: loading
                          ? const NeverScrollableScrollPhysics()
                          : const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return const HomeJobCreate();
                        }
                        if (loading) {
                          return const ProjectListSkeleton();
                        }
                        if (pl.projectListModel.projects?.projects?.isEmpty ??
                            true) {
                          return SizedBox(
                              height: context.height - (context.height / 3),
                              child: EmptyWidget(
                                title: LocalKeys.noProjectsFound,
                                physics: const NeverScrollableScrollPhysics(),
                                margin: EdgeInsets.zero,
                              ));
                        }
                        if ((pl.nextPage != null && !pl.nexLoadingFailed) &&
                            index ==
                                (pl.projectListModel.projects!.projects!
                                        .length +
                                    1)) {
                          return ScrollPreloader(loading: pl.nextPageLoading);
                        }
                        final pItem =
                            pl.projectListModel.projects!.projects![index - 1];
                        return ProjectCard(
                          project: pItem,
                          projectsPath:
                              pl.projectListModel.projectFilePath ?? "",
                        );
                      },
                      separatorBuilder: (context, index) => 16.toHeight,
                      itemCount: (pl.projectListModel.projects?.projects
                                  ?.length ??
                              0) +
                          ((pl.projectListModel.projects?.projects?.length ??
                                      0) ==
                                  0
                              ? 1
                              : 0) +
                          (pl.nextPage != null && !pl.nexLoadingFailed
                              ? 2
                              : 1));
                });
          },
        );
      }),
    );
  }
}
