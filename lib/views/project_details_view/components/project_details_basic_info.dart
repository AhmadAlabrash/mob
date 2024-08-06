import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/project_details_service.dart';
import 'package:xilancer/utils/components/image_pl_widget.dart';

class ProjectDetailsBasicInfo extends StatelessWidget {
  final bool showEdit;
  final projectId;
  const ProjectDetailsBasicInfo(
      {super.key, this.showEdit = true, this.projectId});

  @override
  Widget build(BuildContext context) {
    final pdProvider =
        Provider.of<ProjectDetailsService>(context, listen: false);
    final projectDetails =
        pdProvider.projectDetailsModel[projectId.toString()]?.projectDetails;
    final projectRating =
        pdProvider.projectDetailsModel[projectId.toString()]?.projectRating ??
            0;
    final ratingCount = projectDetails?.ratingCount ?? 0;
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: (context.width - 72) * 0.54237,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl:
                    "${pdProvider.projectFilePath}/${pdProvider.projectDetailsModel[projectId.toString()]?.projectDetails?.image}",
                placeholder: (context, url) => const ImagePLWidget(size: 60),
                errorWidget: (context, url, error) =>
                    const ImagePLWidget(size: 60),
              ),
            ),
          ),
          16.toHeight,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.dProvider.yellowColor.withOpacity(0.10),
                ),
                child: FittedBox(
                  child: Row(
                    children: [
                      if (projectRating > 0)
                        Icon(
                          Icons.star_rounded,
                          color: context.dProvider.yellowColor,
                          size: 20,
                        ),
                      if (projectRating > 0) 4.toWidth,
                      Text(
                        projectRating > 0
                            ? "${projectRating.toStringAsFixed(1)} ($ratingCount)"
                            : LocalKeys.noReview,
                        style: context.titleSmall
                            ?.copyWith(color: context.dProvider.yellowColor)
                            .bold6,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.dProvider.greenColor.withOpacity(.20),
                ),
                child: Text(
                  (pdProvider.projectDetailsModel[projectId.toString()]
                                  ?.projectDetails?.completeOrdersCount ??
                              0) >
                          0
                      ? "${pdProvider.projectDetailsModel[projectId.toString()]?.projectDetails?.completeOrdersCount} ${LocalKeys.ordersCompleted}"
                      : LocalKeys.noOrder,
                  style: context.bodySmall
                      ?.copyWith(color: context.dProvider.greenColor)
                      .bold6,
                ),
              ),
            ],
          ),
          8.toHeight,
          Text(projectDetails?.title ?? "---",
              style: context.titleMedium?.bold6),
          8.toHeight,
          HtmlWidget(projectDetails?.description ?? ""),
        ],
      ),
    );
  }
}
