import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/utils/components/field_label.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/utils/components/pass_field_with_label.dart';
import 'package:xilancer/view_models/delete_account_view_model/delete_account_view_model.dart';

class DeleteAccountView extends StatelessWidget {
  static const routeName = 'delete_account_view';
  const DeleteAccountView({super.key});
  @override
  Widget build(BuildContext context) {
    final dam = DeleteAccountViewModel.instance;
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationPopIcon(),
          title: Text(LocalKeys.deleteAccount),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.dProvider.whiteColor),
            child: Form(
              key: dam.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FieldLabel(label: LocalKeys.describeReason),
                  TextFormField(
                    minLines: 4,
                    maxLines: 4,
                    controller: dam.reasonController,
                    decoration:
                        InputDecoration(hintText: LocalKeys.describeReasonDesc),
                    validator: (value) {
                      if ((value?.trim() ?? "").length < 70) {
                        return LocalKeys.provideAtLeastReason;
                      }
                      return null;
                    },
                  ),
                  16.toHeight,
                  PassFieldWithLabel(
                    label: LocalKeys.password,
                    hintText: LocalKeys.enterPassword,
                    controller: dam.passController,
                    valueListenable: dam.passVN,
                  ),
                  20.toHeight,
                  CustomButton(
                      onPressed: () {
                        dam.tryDeletingAccount(context);
                      },
                      btText: LocalKeys.deleteAccount,
                      isLoading: false),
                ],
              ),
            ),
          ),
        ));
  }
}
