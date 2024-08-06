import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../../../view_models/home_drawer_view_model/home_drawer_view_model.dart';

class FilterJobType extends StatelessWidget {
  const FilterJobType({
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
            LocalKeys.jobType.capitalizeWords,
            style: context.titleMedium?.bold6,
          ),
          16.toHeight,
          ValueListenableBuilder(
            valueListenable: hdm.selectedJT,
            builder: (context, value, child) => Column(
                children: JobTypes.values
                    .toList()
                    .map((e) => Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: value == e
                                  ? context.dProvider.primaryColor
                                  : context.dProvider.black7,
                            ),
                          ),
                          child: RadioListTile(
                            value: e,
                            groupValue: value,
                            onChanged: (value) {
                              hdm.selectedJT.value = e;
                            },
                            title: Text(
                              jobTypeLabel(e),
                              style: context.titleSmall
                                  ?.copyWith(color: context.dProvider.black5)
                                  .bold6,
                            ),
                            dense: true,
                          ),
                        ))
                    .toList()),
          )
        ],
      ),
    );
  }

  String jobTypeLabel(JobTypes jt) {
    switch (jt) {
      case JobTypes.FIXED:
        return LocalKeys.fixedPrice;

      default:
        return LocalKeys.any;
    }
  }
}

enum JobTypes {
  ANY,
  FIXED,
}
