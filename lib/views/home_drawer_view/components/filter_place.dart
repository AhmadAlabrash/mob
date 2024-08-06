import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/utils/components/country_dropdown.dart';
import 'package:xilancer/utils/components/state_dropdown.dart';

import '../../../view_models/home_drawer_view_model/home_drawer_view_model.dart';

class FilterPlace extends StatelessWidget {
  const FilterPlace({
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
        children: [
          CountryDropdown(countryNotifier: hdm.selectedCountry),
        ],
      ),
    );
  }
}
