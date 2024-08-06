import 'package:flutter/material.dart';
import 'package:xilancer/app_static_values.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/country_dropdown.dart';
import 'package:xilancer/utils/components/custom_dropdown.dart';
import 'package:xilancer/utils/components/field_label.dart';

import '../../../view_models/home_drawer_view_model/home_drawer_view_model.dart';

class FilterLengths extends StatelessWidget {
  const FilterLengths({
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
          FieldLabel(label: LocalKeys.projectLength),
          ValueListenableBuilder(
              valueListenable: hdm.selectedLengths,
              builder: (context, length, ching) {
                return CustomDropdown(
                  LocalKeys.selectLengths,
                  jobLengths,
                  (value) {
                    hdm.selectedLengths.value = value;
                  },
                  value: length,
                );
              }),
        ],
      ),
    );
  }
}
