import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/view_models/home_drawer_view_model/home_drawer_view_model.dart';

class FilterRating extends StatelessWidget {
  const FilterRating({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hdm = HomeDrawerViewModel.instance;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalKeys.jobPriceBudget.capitalizeWords,
            style: context.titleMedium?.bold6,
          ),
          16.toHeight,
          RatingBar.builder(
            itemSize: 28,
            initialRating: hdm.rating,
            unratedColor: context.dProvider.black7,
            itemBuilder: (context, index) => Icon(
              Icons.star_rounded,
              color: context.dProvider.yellowColor,
            ),
            onRatingUpdate: (value) {},
          )
        ],
      ),
    );
  }
}
