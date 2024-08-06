import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';

import '../../../helper/local_keys.g.dart';
import '../../../utils/components/field_label.dart';
import '../../../view_models/home_drawer_view_model/home_drawer_view_model.dart';

class FilterRatings extends StatelessWidget {
  const FilterRatings({super.key});

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
          FieldLabel(label: LocalKeys.projectLength),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: ValueListenableBuilder(
                    valueListenable: hdm.ratings,
                    builder: (context, rating, ching) {
                      return RatingBar.builder(
                        initialRating: rating ?? 0,
                        itemBuilder: (context, index) => Icon(
                          Icons.star_rounded,
                          color: context.dProvider.yellowColor,
                          size: 20,
                        ),
                        onRatingUpdate: (value) {
                          hdm.ratings.value = value;
                        },
                      );
                    }),
              ),
              12.toWidth,
            ],
          ),
        ],
      ),
    );
  }
}
