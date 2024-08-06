import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';

class SkillChip extends StatelessWidget {
  const SkillChip({
    super.key,
    required this.skill,
  });

  final skill;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: context.dProvider.black8,
            )),
        child: Row(
          children: [
            Text(
              skill,
              style: context.titleSmall
                  ?.copyWith(color: context.dProvider.black5)
                  .bold6,
            ),
          ],
        ),
      ),
    );
  }
}
