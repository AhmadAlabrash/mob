import 'package:flutter/material.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_dropdown.dart';
import 'package:xilancer/utils/components/field_label.dart';
import 'package:xilancer/utils/components/field_with_label.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';
import 'package:xilancer/views/create_project_view/components/add_skill.dart';
import 'package:xilancer/views/create_project_view/components/job_attachment_select.dart';

import '../../../helper/svg_assets.dart';
import 'create_job_buttons.dart';
import 'skill_chip.dart';

class JobSkillBudget extends StatelessWidget {
  const JobSkillBudget({super.key});

  @override
  Widget build(BuildContext context) {
    final cjm = CreateJobViewModel.instance;
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
        ),
        child: Form(
          key: cjm.sbFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FieldLabel(
                isRequired: true,
                label: LocalKeys.jobType,
              ),
              CustomDropdown(
                LocalKeys.selectJobType,
                [LocalKeys.fixedPrice],
                (value) {},
                value: LocalKeys.fixedPrice,
              ),
              8.toHeight,
              FieldLabel(
                label: LocalKeys.skills,
                isRequired: true,
              ),
              ValueListenableBuilder(
                valueListenable: cjm.skillList,
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
                          ...cjm.skillList.value
                              .map((e) => SkillChip(
                                    skill: e,
                                    cjm: cjm,
                                  ))
                              .toList(),
                          const AddSkill(),
                        ],
                      ));
                },
              ),
              8.toHeight,
              FieldWithLabel(
                isRequired: true,
                label: LocalKeys.jobPriceBudget,
                hintText: LocalKeys.enterYourBudget,
                controller: cjm.priceController,
                keyboardType: TextInputType.number,
                prefixIcon: SizedBox(
                  width: 24,
                  child: Center(
                    child: Text(
                      dProvider.currencySymbol,
                      style: context.titleLarge?.bold6.copyWith(
                        color: context.dProvider.black5,
                      ),
                    ),
                  ),
                ),
                validator: (value) {
                  return (num.tryParse(value.toString()) ?? 0) < 1
                      ? LocalKeys.enterValidAmount
                      : null;
                },
              ),
              JobAttachmentSelect(suv: cjm),
              20.toHeight,
              const CreateProjectButtons(
                lastPage: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
