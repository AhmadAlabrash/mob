import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/models/category_model.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';

class SubCategoryChip extends StatelessWidget {
  const SubCategoryChip({
    super.key,
    required this.subcategory,
  });

  final SubCategory subcategory;

  @override
  Widget build(BuildContext context) {
    final cjm = CreateJobViewModel.instance;
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
          border: Border.all(color: context.dProvider.black8, width: 1),
        ),
        child: Row(
          children: [
            Text(
              subcategory.subCategory ?? "---",
              style: context.titleSmall
                  ?.copyWith(color: context.dProvider.black5)
                  .bold6,
            ),
            6.toWidth,
            GestureDetector(
                onTap: () {
                  cjm.selectedSubcategories.value.removeWhere((element) =>
                      element.id.toString() == subcategory.id.toString());
                  cjm.selectedSubcategories.notifyListeners();
                },
                child: Icon(
                  Icons.close_rounded,
                  color: context.dProvider.black4,
                  size: 20,
                ))
          ],
        ),
      ),
    );
  }
}
