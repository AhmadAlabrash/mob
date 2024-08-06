import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/models/skill_dropdown_model.dart';
import 'package:xilancer/services/skill_dropdown_service.dart';
import 'package:xilancer/utils/components/skill_sheet.dart';
import 'package:xilancer/utils/components/subcategory_sheet.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';

import '../../../helper/local_keys.g.dart';
import '../../../services/category_dropdown_service.dart';

class AddSkill extends StatelessWidget {
  const AddSkill({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cpv = CreateJobViewModel.instance;
    return FittedBox(
      child: GestureDetector(
        onTap: () {
          Provider.of<SkillDropdownService>(context, listen: false).resetList();
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => SkillSheet(
              onChanged: (Skill subCat) {
                cpv.skillList.value.add(subCat);
                cpv.skillList.notifyListeners();
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.dProvider.whiteColor,
          ),
          child: Row(
            children: [
              Text(
                LocalKeys.addSkill,
                style: context.titleSmall
                    ?.copyWith(color: context.dProvider.black5)
                    .bold6,
              ),
              6.toWidth,
              Icon(
                Icons.add_rounded,
                color: context.dProvider.black4,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
