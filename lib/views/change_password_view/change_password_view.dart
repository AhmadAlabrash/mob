import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import '/helper/local_keys.g.dart';
import '/utils/components/custom_button.dart';
import '/utils/components/empty_spacer_helper.dart';
import '/view_models/change_password_view_model/change_password_view_model.dart';

import '../../helper/svg_assets.dart';
import '../../utils/components/pass_field_with_label.dart';

class ChangePasswordView extends StatelessWidget {
  static const routeName = 'change_password_view';
  const ChangePasswordView({super.key});
  @override
  Widget build(BuildContext context) {
    final cpv = ChangePasswordViewModel.instance;

    return Scaffold(
        body: Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
        title: Text(LocalKeys.changePassword),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: context.dProvider.whiteColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8), topRight: Radius.circular(8))),
          child: Form(
            key: cpv.formKey,
            child: Column(
              children: [
                PassFieldWithLabel(
                  label: LocalKeys.currentPassword,
                  hintText: LocalKeys.enterCurrentPassword,
                  valueListenable: cpv.obscurePassCur,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  controller: cpv.currentPassController,
                  svgPrefix: SvgAssets.lock,
                  validator: (pass) {
                    return pass.toString().length < 8
                        ? LocalKeys.passDigitWarning
                        : null;
                  },
                ),
                EmptySpaceHelper.emptyHeight(16),
                PassFieldWithLabel(
                  label: LocalKeys.newPassword,
                  hintText: LocalKeys.enterNewPassword,
                  valueListenable: cpv.obscurePassNew,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  controller: cpv.newPassController,
                  svgPrefix: SvgAssets.lock,
                  validator: (pass) {
                    return pass.toString().length < 8
                        ? LocalKeys.passDigitWarning
                        : null;
                  },
                ),
                EmptySpaceHelper.emptyHeight(16),
                PassFieldWithLabel(
                  label: LocalKeys.confirmPass,
                  hintText: LocalKeys.reEnterPassword,
                  valueListenable: cpv.obscurePassCon,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.next,
                  svgPrefix: SvgAssets.lock,
                  validator: (value) {
                    if (cpv.newPassController.text != value) {
                      return LocalKeys.passwordDidNotMatch;
                    }
                    return null;
                  },
                ),
                EmptySpaceHelper.emptyHeight(16),
                ValueListenableBuilder(
                  valueListenable: cpv.isLoading,
                  builder: (context, loading, child) => CustomButton(
                      onPressed: () {
                        cpv.tryChangingPassword(context);
                      },
                      btText: LocalKeys.changePassword,
                      isLoading: loading),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
