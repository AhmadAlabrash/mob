import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/utils/components/custom_dropdown.dart';
import 'package:xilancer/utils/components/field_with_label.dart';
import 'package:xilancer/view_models/place_order_view_model/place_order_view_model.dart';

import '../../../app_static_values.dart';
import '../../../helper/local_keys.g.dart';
import '../../../utils/components/field_label.dart';
import '../../conversation_view/components/send_offer_sheet.dart';
import 'milestone_sheet_buttons.dart';

class MilestoneSheet extends StatelessWidget {
  final bool editing;
  final dynamic id;
  const MilestoneSheet({
    super.key,
    this.editing = false,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final pom = PlaceOrderViewViewModel.instance;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: context.dProvider.whiteColor,
      ),
      constraints: BoxConstraints(
          maxHeight: context.height / 2 +
              (MediaQuery.of(context).viewInsets.bottom / 2)),
      child: Form(
          key: pom.formKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 4,
                  width: 48,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: context.dProvider.black7,
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: EdgeInsets.only(
                    right: 20,
                    left: 20,
                    top: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom < 20
                        ? 20
                        : MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FieldWithLabel(
                      label: LocalKeys.milestoneName,
                      hintText: LocalKeys.enterName,
                      isRequired: true,
                      controller: pom.nameController,
                      textInputAction: TextInputAction.next,
                      validator: (name) {
                        return name.toString().length < 5
                            ? LocalKeys.invalidName
                            : null;
                      },
                    ),
                    FieldWithLabel(
                      label: LocalKeys.description,
                      hintText: LocalKeys.writeMilestoneDesc,
                      controller: pom.descriptionController,
                      minLines: 3,
                      isRequired: true,
                      validator: (name) {
                        return name.toString().length < 5
                            ? LocalKeys.invalidName
                            : null;
                      },
                    ),
                    FieldWithLabel(
                      label: LocalKeys.milestoneAmount,
                      hintText: "123",
                      isRequired: true,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      prefixIcon: const CurrencyPrefix(),
                      controller: pom.priceController,
                      validator: (price) {
                        final amount = price.toString().tryToParse;
                        if (amount < 0) {
                          return LocalKeys.enterValidAmount;
                        }
                        return null;
                      },
                    ),
                    FieldWithLabel(
                      label: LocalKeys.revision,
                      hintText: LocalKeys.enterRevisionAmount,
                      isRequired: true,
                      controller: pom.revisionController,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      validator: (price) {
                        final amount = price.toString().tryToParse;
                        if (amount < 0) {
                          return LocalKeys.enterValidAmount;
                        }
                        return null;
                      },
                    ),
                    FieldLabel(
                      label: LocalKeys.deliveryTime,
                      isRequired: true,
                    ),
                    ValueListenableBuilder(
                      valueListenable: pom.selectedDDate,
                      builder: (context, dDate, child) {
                        return CustomDropdown(
                          LocalKeys.selectLengths,
                          jobLengths,
                          (value) {
                            pom.selectedDDate.value = value;
                          },
                          value: dDate,
                        );
                      },
                    ),
                    16.toHeight,
                    MilestoneSheetButtons(
                      editing: editing,
                      id: id,
                    ),
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
