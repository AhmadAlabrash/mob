import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../../../view_models/home_drawer_view_model/home_drawer_view_model.dart';

class FilterExp extends StatelessWidget {
  const FilterExp({
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
            LocalKeys.expLevel.capitalizeWords,
            style: context.titleMedium?.bold6,
          ),
          16.toHeight,
          ValueListenableBuilder(
            valueListenable: hdm.selectedExp,
            builder: (context, value, child) => Column(
                children: ExperienceLav.values
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
                              hdm.selectedExp.value = e;
                            },
                            title: Text(
                              expLabel(e),
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
}

String expLabel(ExperienceLav exp, {translate = true}) {
  switch (exp) {
    case ExperienceLav.SENIOR:
      return translate ? LocalKeys.seniorLevel.tr() : LocalKeys.seniorLevel;
    case ExperienceLav.MID:
      return translate ? LocalKeys.midLevel.tr() : LocalKeys.midLevel;
    case ExperienceLav.JUNIOR:
      return translate ? LocalKeys.juniorLevel.tr() : LocalKeys.juniorLevel;
    default:
      return translate ? LocalKeys.any : LocalKeys.anyH;
  }
}

enum ExperienceLav {
  ANY,
  SENIOR,
  MID,
  JUNIOR,
}
