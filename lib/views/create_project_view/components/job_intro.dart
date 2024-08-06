import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/category_dropdown.dart';
import 'package:xilancer/utils/components/field_with_label.dart';
import 'package:xilancer/views/create_project_view/components/add_subcategory.dart';
import 'package:xilancer/views/create_project_view/components/subcategory_chip.dart';

import '../../../app_static_values.dart';
import '../../../utils/components/custom_dropdown.dart';
import '../../../utils/components/field_label.dart';
import '../../../view_models/create_job_view_model/create_job_view_model.dart';
import 'create_job_buttons.dart';

class JobIntro extends StatelessWidget {
  final CreateJobViewModel cjm;
  const JobIntro({
    super.key,
    required this.cjm,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
        ),
        child: Form(
          key: cjm.introFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FieldWithLabel(
                    label: LocalKeys.jobName,
                    hintText: LocalKeys.jobNameHint,
                    controller: cjm.titleController,
                    isRequired: true,
                    validator: (value) {
                      return value.toString().length < 5
                          ? LocalKeys.invalidJobTitle
                          : null;
                    },
                    onChanged: (name) {
                      cjm.slugController.text =
                          name?.toString().trim().replaceAll(" ", "-") ?? "";
                    },
                  ),
                  FieldWithLabel(
                    label: LocalKeys.slug,
                    hintText: LocalKeys.enterSlug,
                    controller: cjm.slugController,
                    isRequired: true,
                    validator: (value) {
                      return (value?.toString() ?? "").isEmpty
                          ? LocalKeys.enterSlug
                          : null;
                    },
                  ),
                  CategoryDropdown(
                    catNotifier: cjm.selectedCategory,
                    isRequired: true,
                    onChanged: (_) {
                      cjm.selectedSubcategories.value.clear();
                      cjm.selectedSubcategories.notifyListeners();
                    },
                  ),
                  16.toHeight,
                  FieldLabel(
                    label: LocalKeys.subcategory,
                    isRequired: true,
                  ),
                  ValueListenableBuilder(
                    valueListenable: cjm.selectedSubcategories,
                    builder: (context, value, child) {
                      return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: context.dProvider.black9,
                          ),
                          constraints: const BoxConstraints(minHeight: 100),
                          child: Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              ...cjm.selectedSubcategories.value
                                  .map((e) => SubCategoryChip(subcategory: e))
                                  .toList(),
                              const AddSubCategory(),
                            ],
                          ));
                    },
                  ),
                  16.toHeight,
                  FieldLabel(
                    label: LocalKeys.jobDuration,
                    isRequired: true,
                  ),
                  ValueListenableBuilder(
                      valueListenable: cjm.selectedLengths,
                      builder: (context, length, ching) {
                        return CustomDropdown(
                          LocalKeys.selectLengths,
                          jobLengths,
                          (value) {
                            cjm.selectedLengths.value = value;
                          },
                          value: length,
                        );
                      }),
                  FieldLabel(
                    label: LocalKeys.experienceLevel,
                    isRequired: true,
                  ),
                  ValueListenableBuilder(
                      valueListenable: cjm.selectedExperienceLevel,
                      builder: (context, experience, ching) {
                        return CustomDropdown(
                          LocalKeys.selectExperienceLevel,
                          jobType,
                          (value) {
                            cjm.selectedExperienceLevel.value = value;
                          },
                          value: experience,
                        );
                      }),
                  FieldWithLabel(
                    controller: cjm.descriptionController,
                    label: LocalKeys.writeJobDescription,
                    isRequired: true,
                    hintText: LocalKeys.jobDescriptionHint,
                    minLines: 3,
                    maxLines: 50,
                    textInputAction: TextInputAction.newline,
                    validator: (value) {
                      return value.toString().length < 50
                          ? LocalKeys.invalidJobDescription
                          : null;
                    },
                  ),
                ],
              ).hp20,
              20.toHeight,
              const CreateProjectButtons().hp20,
            ],
          ),
        ),
      ),
    );
  }
}
