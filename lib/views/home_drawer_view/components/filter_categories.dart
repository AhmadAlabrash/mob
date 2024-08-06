import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/utils/components/category_dropdown.dart';
import 'package:xilancer/utils/components/subcategory_dropdown.dart';

import '../../../view_models/home_drawer_view_model/home_drawer_view_model.dart';

class FilterCategories extends StatelessWidget {
  const FilterCategories({
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
          CategoryDropdown(
            catNotifier: hdm.selectedCategory,
            onChanged: (value) {
              hdm.selectedSubCat.value = null;
            },
          ),
          16.toHeight,
          SubcategoryDropdown(
            catNotifier: hdm.selectedCategory,
            subCatNotifier: hdm.selectedSubCat,
          ),
        ],
      ),
    );
  }
}
