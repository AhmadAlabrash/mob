import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/view_models/onboarding_view_model/onboarding_view_model.dart';
import 'package:xilancer/views/sign_in_view/components/social_sign_in.dart';

import '../../helper/local_keys.g.dart';
import '../../utils/components/custom_button.dart';
import '../../utils/components/empty_spacer_helper.dart';
import '../../utils/components/field_with_label.dart';
import '../../utils/components/navigation_pop_icon.dart';
import '../../utils/components/pass_field_with_label.dart';
import '../../view_models/sign_in_view/sign_in_view_model.dart';
import 'components/create_account.dart';
import 'components/forgot_password.dart';
import 'components/remember_password.dart';

class SignInView extends StatelessWidget {
  static const routeName = 'sign_in_view';
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final siv = SignInViewModel.instance;

    return Scaffold(
      appBar: AppBar(
          leading: const NavigationPopIcon(), title: Text(LocalKeys.signIn)),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: context.dProvider.whiteColor,
                borderRadius: BorderRadius.circular(8)),
            child: AutofillGroup(
              child: Form(
                key: siv.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EmptySpaceHelper.emptyHeight(24),
                    FieldWithLabel(
                      label: LocalKeys.emailOrUsername,
                      hintText: LocalKeys.enterEmailOrUsername,
                      keyboardType: TextInputType.emailAddress,
                      controller: siv.emailUsernameController,
                      autofillHints: const [
                        AutofillHints.email,
                        AutofillHints.username
                      ],
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return LocalKeys.enterEmailOrUsername;
                        }
                        return null;
                      },
                    ),
                    EmptySpaceHelper.emptyHeight(8),
                    PassFieldWithLabel(
                      label: LocalKeys.password,
                      hintText: LocalKeys.enterPassword,
                      valueListenable: siv.obscurePass,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      controller: siv.passwordController,
                      autofillHints: const [
                        AutofillHints.password,
                      ],
                      onFieldSubmitted: (value) {
                        siv.signIn(context);
                      },
                      validator: (value) {
                        if (value!.length < 8) {
                          return LocalKeys.passLeastCharWarning;
                        }
                        return null;
                      },
                    ),
                    EmptySpaceHelper.emptyHeight(8),
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child:
                              RememberPassword(rememberPass: siv.rememberPass),
                        ),
                        const Expanded(flex: 1, child: SizedBox()),
                        const Expanded(flex: 10, child: ForgotPassword()),
                      ],
                    ),
                    EmptySpaceHelper.emptyHeight(8),
                    ValueListenableBuilder(
                      valueListenable: siv.loading,
                      builder: (context, loading, child) => CustomButton(
                        onPressed: () async {
                          siv.signIn(context);
                        },
                        btText: LocalKeys.signIn,
                        isLoading: loading,
                      ),
                    ),
                    EmptySpaceHelper.emptyHeight(16),
                    const CreateAccount(),
                    EmptySpaceHelper.emptyHeight(16),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
