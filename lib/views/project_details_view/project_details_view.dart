import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/views/project_details_view/components/project_details_basic_info.dart';
import 'package:xilancer/views/project_details_view/components/project_details_package.dart';

import '../../helper/svg_assets.dart';
import '../../models/project_list_model.dart';
import '../../services/bookmark_data_service.dart';
import '../../services/project_details_service.dart';
import 'components/freelancer_info.dart';
import 'components/project_details_skeleton.dart';

class ProjectDetailsView extends StatelessWidget {
  static const routeName = 'project_details_view';
  const ProjectDetailsView({super.key});
  @override
  Widget build(BuildContext context) {
    final List routeData =
        (ModalRoute.of(context)?.settings.arguments ?? []) as List;
    final id = routeData[0];
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationPopIcon(),
          title: Text(LocalKeys.projectDetails),
          actions: [
            Consumer<ProjectDetailsService>(builder: (context, pd, child) {
              final project = pd.projectDetailsModel[id.toString()];
              final projectDetails = project?.projectDetails;
              return projectDetails == null
                  ? const SizedBox()
                  : Consumer<BookmarkDataService>(
                      builder: (context, bd, child) {
                      final isBookmarked =
                          bd.isBookmarked(id.toString().toString());
                      return GestureDetector(
                        onTap: () {
                          final proj = Project(
                            id: projectDetails.id,
                            basicRegularCharge:
                                projectDetails.basicRegularCharge,
                            basicDiscountCharge:
                                projectDetails.basicDiscountCharge,
                            basicDelivery: projectDetails.basicDelivery,
                            image: projectDetails.image,
                            ratingCount: projectDetails.ratingCount,
                            avgRating: project?.projectRating ?? 0,
                            completeOrdersCount:
                                projectDetails.completeOrdersCount,
                            title: projectDetails.title,
                          );
                          final data = proj.toJson();

                          bd.toggleBookmark(proj.id.toString(), data);
                        },
                        child: Container(
                          height: 32,
                          width: 32,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isBookmarked
                                ? context.dProvider.primaryColor
                                : context.dProvider.black8,
                          ),
                          child: (isBookmarked
                                  ? SvgAssets.bookmarkSub
                                  : SvgAssets.bookmarkAdd)
                              .toSVGSized(18,
                                  color: isBookmarked
                                      ? context.dProvider.whiteColor
                                      : null),
                        ),
                      );
                    });
            }),
            16.toWidth,
          ],
        ),
        body: Consumer<ProjectDetailsService>(builder: (context, pd, child) {
          return CustomFutureWidget(
            function: pd.shouldAutoFetch(id)
                ? pd.fetchOrderDetails(projectId: id)
                : null,
            shimmer: const ProjectDetailsSkeleton(),
            child: ListView(
              children: [
                ProjectDetailsBasicInfo(
                  showEdit: routeData.isEmpty,
                  projectId: id,
                ),
                FreelancerInfo(
                  projectId: id,
                ),
                20.toHeight,
                ProjectDetailsPackages(
                  projectId: id,
                )
              ],
            ),
          );
        }));
  }
}
