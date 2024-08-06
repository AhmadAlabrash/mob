import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/utils/components/empty_spacer_helper.dart';

class ChoseRoleCard extends StatelessWidget {
  final title;
  final String icon;
  final isSelected;
  final ontap;
  const ChoseRoleCard(
      {super.key,
      required this.title,
      required this.icon,
      required this.isSelected,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: isSelected ? context.dProvider.primary05 : Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: isSelected
                      ? context.dProvider.primaryColor
                      : context.dProvider.black7,
                  width: 1.5)),
          padding: const EdgeInsets.all(26),
          child: Column(
            children: [
              icon.toSVGSized(
                52,
                color: isSelected
                    ? context.dProvider.primaryColor
                    : context.dProvider.black5,
              ),
              EmptySpaceHelper.emptyHeight(16),
              Text(
                title,
                style: context.titleMedium
                    ?.copyWith(
                        color: isSelected
                            ? context.dProvider.primaryColor
                            : context.dProvider.black5)
                    .bold6,
              ),
            ],
          )),
    );
  }
}
