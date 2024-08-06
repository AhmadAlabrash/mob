import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/project_details_service.dart';
import 'package:xilancer/utils/components/image_pl_widget.dart';
import 'package:xilancer/view_models/project_details_view_model/project_details_view_model.dart';

import '../../../helper/svg_assets.dart';
import '../../../models/project_list_model.dart';
import '../../../services/bookmark_data_service.dart';
import '../../project_details_view/project_details_view.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final String projectsPath;
  final bool pop;
  const ProjectCard(
      {super.key,
      required this.project,
      required this.projectsPath,
      this.pop = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ProjectDetailsViewModel.dispose;
        context.toNamed(ProjectDetailsView.routeName, arguments: [project.id],
            then: () {
          Provider.of<ProjectDetailsService>(context, listen: false)
              .removeProject(id: project.id);
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: (context.width - 72) * 0.54237,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: "$projectsPath/${project.image}",
                      placeholder: (context, url) =>
                          const ImagePLWidget(size: 60),
                      errorWidget: (context, url, error) =>
                          const ImagePLWidget(size: 60),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Consumer<BookmarkDataService>(
                        builder: (context, bd, child) {
                      final isBookmarked =
                          bd.isBookmarked(project.id.toString());
                      return GestureDetector(
                        onTap: () {
                          final data = project.toJson();

                          bd.toggleBookmark(project.id.toString(), data);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.all(12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: isBookmarked
                                ? context.dProvider.primaryColor
                                : context.dProvider.black7,
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
                    }),
                  ],
                ),
              ],
            ),
            16.toHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: context.dProvider.yellowColor.withOpacity(0.10),
                  ),
                  child: FittedBox(
                    child: Row(
                      children: [
                        if (project.ratingCount > 0)
                          Icon(
                            Icons.star_rounded,
                            color: context.dProvider.yellowColor,
                            size: 20,
                          ),
                        Text(
                          project.ratingCount > 0
                              ? "${project.avgRating?.toStringAsFixed(1) ?? 0}(${project.ratingCount})"
                              : LocalKeys.noReview,
                          style: context.titleSmall
                              ?.copyWith(color: context.dProvider.yellowColor)
                              .bold6,
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: context.dProvider.greenColor.withOpacity(.20),
                  ),
                  child: Text(
                    project.completeOrdersCount > 0
                        ? "${project.completeOrdersCount} ${LocalKeys.ordersCompleted}"
                        : LocalKeys.noOrder,
                    style: context.bodySmall
                        ?.copyWith(color: context.dProvider.greenColor)
                        .bold6,
                  ),
                ),
              ],
            ),
            8.toHeight,
            Text(project.title ?? "", style: context.titleMedium?.bold6),
            8.toHeight,
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          "${LocalKeys.from}: ",
                          style: context.titleMedium
                              ?.copyWith(color: context.dProvider.black6)
                              .bold6,
                        ),
                        Text(
                          ((project.basicDiscountCharge ??
                                  project.basicRegularCharge))
                              .toStringAsFixed(0)
                              .cur,
                          style: context.titleMedium
                              ?.copyWith(color: context.dProvider.primaryColor)
                              .bold6,
                        ),
                        6.toWidth,
                        if ((project.basicDiscountCharge ?? 0) > 0)
                          Text(
                            (project.basicRegularCharge).toStringAsFixed(0).cur,
                            style: context.titleSmall
                                ?.copyWith(
                                    color: context.dProvider.black6,
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor: context.dProvider.black6)
                                .bold6,
                          ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgAssets.clock.toSVGSized(20),
                        8.toWidth,
                        Expanded(
                          flex: 1,
                          child: RichText(
                            maxLines: 2,
                            text: TextSpan(
                                text: LocalKeys.deliveryTime,
                                style: context.titleSmall
                                    ?.copyWith(color: context.dProvider.black5),
                                children: [
                                  TextSpan(
                                      text: " ${project.basicDelivery ?? ""}",
                                      style: context.titleSmall
                                          ?.copyWith(
                                              color: context.dProvider.black5)
                                          .bold6)
                                ]),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
