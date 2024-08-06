import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/phone_field.dart';
import 'package:xilancer/utils/components/field_label.dart';
import 'package:xilancer/utils/components/pass_field_with_label.dart';
import 'package:xilancer/views/sign_up_view/components/name_field.dart';
import 'package:xilancer/views/sign_up_view/components/social_sign_in.dart';

import '../../services/auth/sign_up_service.dart';
import '../../utils/components/field_with_label.dart';
import '../../utils/components/navigation_pop_icon.dart';
import '../../utils/components/tac_pp.dart';
import '/view_models/sign_up_view/sign_up_view_model.dart';
import 'components/sign_in_to_account.dart';
import '../../utils/components/custom_button.dart';
import '/helper/local_keys.g.dart';
import '../../utils/components/empty_spacer_helper.dart';

class SignUpView extends StatelessWidget {
  static const routeName = 'sign_up_view';
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    final suv = SignUpViewModel.instance;

    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
        title: Text(LocalKeys.createAnAccount),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: context.dProvider.whiteColor,
              borderRadius: BorderRadius.circular(8)),
          child: AutofillGroup(
            child: Form(
              key: suv.formKey,
              child: Column(
                children: [
                  NameField(
                    firstNameController: suv.firstNameController,
                    lastNameController: suv.lastNameController,
                  ),
                  FieldWithLabel(
                    label: LocalKeys.username,
                    hintText: LocalKeys.enterUsername,
                    controller: suv.usernameController,
                    autofillHints: const [AutofillHints.newUsername],
                    validator: (value) {
                      if (value!.length < 3) {
                        return LocalKeys.enterLeastUsername;
                      }
                      return null;
                    },
                  ),
                  FieldWithLabel(
                    label: LocalKeys.email,
                    hintText: LocalKeys.enterEmail,
                    keyboardType: TextInputType.emailAddress,
                    controller: suv.emailController,
                    autofillHints: const [AutofillHints.email],
                    validator: (value) {
                      if (!value!.validateEmail) {
                        return LocalKeys.enterValidEmailAddress;
                      }
                      return null;
                    },
                  ),
                  FieldWithLabel(
                    label: LocalKeys.phoneNumber,
                    hintText: LocalKeys.enterPhone,
                    controller: suv.phoneController,
                    keyboardType: TextInputType.number,
                    autofillHints: const [AutofillHints.telephoneNumber],
                    validator: (value) {
                      if (value!.length < 5) {
                        return LocalKeys.enterValidPhone;
                      }
                      return null;
                    },
                  ),
                  PassFieldWithLabel(
                    label: LocalKeys.password,
                    hintText: LocalKeys.enterPassword,
                    autofillHints: const [AutofillHints.newPassword],
                    controller: suv.passwordController,
                    valueListenable: suv.obscurePassNew,
                  ),
                  EmptySpaceHelper.emptyHeight(16),
                  PassFieldWithLabel(
                    label: LocalKeys.confirmPass,
                    valueListenable: suv.obscurePassConfirm,
                    hintText: LocalKeys.enterPassword,
                    validator: (pass) {
                      if (pass != suv.passwordController.text) {
                        return LocalKeys.passwordDidNotMatch;
                      }
                      return null;
                    },
                  ),
                  EmptySpaceHelper.emptyHeight(16),
                  TacPp(
                    valueListenable: suv.tacPpAccept,
                  ),
                  EmptySpaceHelper.emptyHeight(16),
                  ValueListenableBuilder(
                    valueListenable: suv.loading,
                    builder: (context, loading, child) => CustomButton(
                      onPressed: () async {
                        suv.signUp(context);
                      },
                      btText: LocalKeys.signUp,
                      isLoading: loading,
                    ),
                  ),
                  EmptySpaceHelper.emptyHeight(24),
                  const SignInToAccount(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
