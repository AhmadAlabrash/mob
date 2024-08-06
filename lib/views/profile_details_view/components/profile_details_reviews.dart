import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/profile_details_service.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_review_card.dart';

class ProfileDetailsReviews extends StatelessWidget {
  final ProfileDetailsService pd;
  const ProfileDetailsReviews({super.key, required this.pd});

  @override
  Widget build(BuildContext context) {
    final reviewFeedbacks = pd.profileDetails.reviewFeedbacks ?? [];
    final reviewRatings = pd.profileDetails.reviewRatings ?? [];
    final reviewProjects = pd.profileDetails.reviewProjects ?? [];
    int index = 0;
    return reviewFeedbacks.isEmpty
        ? const SizedBox()
        : Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.dProvider.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocalKeys.reviews, style: context.titleMedium?.bold6),
                  ],
                ).hp20,
                Divider(
                  color: context.dProvider.black8,
                  thickness: 2,
                  height: 36,
                ),
                ...reviewRatings.map((rating) {
                  return rating == null || rating == 0 || index > 6
                      ? SizedBox(
                          width: (index++).toDouble(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileDetailsReviewCard(
                              title: reviewProjects[index] ?? "",
                              review: reviewFeedbacks[index] ?? "",
                              rating: reviewRatings[index++],
                            ),
                            Divider(
                              color: context.dProvider.black8,
                              thickness: 2,
                              height: 36,
                            ),
                          ],
                        );
                }).toList()
              ],
            ),
          );
  }
}
