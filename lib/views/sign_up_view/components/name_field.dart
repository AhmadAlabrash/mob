import 'package:flutter/material.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/field_with_label.dart';

class NameField extends StatelessWidget {
  final TextEditingController? firstNameController;
  final TextEditingController? lastNameController;
  const NameField(
      {super.key, this.firstNameController, this.lastNameController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: FieldWithLabel(
            controller: firstNameController,
            label: LocalKeys.firstName,
            hintText: LocalKeys.firstName0,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.namePrefix],
            validator: (value) {
              if (value!.length < 2) {
                return LocalKeys.enterValidName;
              }
              return null;
            },
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 6,
          child: FieldWithLabel(
            controller: lastNameController,
            label: LocalKeys.lastName,
            textInputAction: TextInputAction.next,
            hintText: LocalKeys.lastName0,
            autofillHints: const [AutofillHints.nameSuffix],
            validator: (value) {
              if (value!.length < 2) {
                return LocalKeys.enterValidName;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
