import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';

class SkillChip extends StatelessWidget {
  const SkillChip({
    super.key,
    required this.cjm,
    required this.skill,
  });

  final skill;
  final CreateJobViewModel cjm;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
        ),
        child: Row(
          children: [
            Text(
              skill.skill,
              style: context.titleSmall
                  ?.copyWith(color: context.dProvider.black5)
                  .bold6,
            ),
            6.toWidth,
            GestureDetector(
                onTap: () {
                  cjm.skillList.value.removeWhere((element) =>
                      element.id.toString() == skill.id.toString());
                  cjm.skillList.notifyListeners();
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
