import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_review_buttons.dart';

import '../../../utils/components/image_pl_widget.dart';

class ProfileDetailsReviewCard extends StatelessWidget {
  final String title;
  final double rating;
  final String? review;
  final postedImage;
  const ProfileDetailsReviewCard({
    super.key,
    this.postedImage = false,
    required this.title,
    required this.rating,
    this.review,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar.builder(
          itemSize: 24,
          initialRating: rating,
          ignoreGestures: true,
          unratedColor: context.dProvider.black7,
          itemBuilder: (context, index) => Icon(
            Icons.star_rounded,
            color: context.dProvider.yellowColor,
          ),
          onRatingUpdate: (value) {},
        ),
        8.toHeight,
        Text(title, maxLines: 2, style: context.titleMedium?.bold6),
        8.toHeight,
        Text(
          "$review",
          style: context.titleSmall?.copyWith(color: context.dProvider.black5),
        ),
      ],
    ).hp20;
  }

  Row infoRows(BuildContext context, title, value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: context.titleSmall?.copyWith(color: context.dProvider.black5),
        ),
        Text(
          value,
          style: context.titleSmall
              ?.copyWith(color: context.dProvider.black5)
              .bold6,
        ),
      ],
    );
  }
}
