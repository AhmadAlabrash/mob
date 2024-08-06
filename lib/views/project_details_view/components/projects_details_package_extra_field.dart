import 'package:flutter/material.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/view_models/project_details_view_model/project_details_view_model.dart';

import '../../../models/packages_model.dart';

class ProjectDetailsPackageExtraField extends StatelessWidget {
  final int index;

  ProjectDetailsPackageExtraField({
    super.key,
    required this.pdm,
    required this.index,
  });
  final ProjectDetailsViewModel pdm;

  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final pdm = ProjectDetailsViewModel.instance;
    final extraField = pdm.packages[pdm.packageIndex.value].extraFields[index];
    nameController.text = extraField.name;
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: context.dProvider.whiteColor,
          border: Border(
            top: BorderSide(color: context.dProvider.black8, width: 1),
            bottom: BorderSide(color: context.dProvider.black8, width: 1),
          )),
      child: Row(
        children: [
          Container(
            width: context.width / 2.2,
            padding: EdgeInsets.only(
              right: dProvider.textDirectionRight ? 20 : 0,
              left: dProvider.textDirectionRight ? 0 : 20,
            ),
            child: Text(
              extraField.name,
              style: context.titleSmall?.bold6,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12, top: 12),
            child: VerticalDivider(
              thickness: 2,
              color: context.dProvider.black8,
            ),
          ),
          Container(
            width: context.width / 2.2,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 12),
            child: extraField.type == FieldType.CHECK
                ? extraField.checked
                    ? Icon(Icons.done_rounded,
                        color: context.dProvider.greenColor)
                    : Icon(Icons.close_rounded,
                        color: context.dProvider.warningColor)
                : Text(extraField.quantity.toString()),
          ),
        ],
      ),
    );
  }
}
