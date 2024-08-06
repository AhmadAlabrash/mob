import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/services/auth/otp_service.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import '/helper/extension/string_extension.dart';
import '/utils/components/custom_button.dart';
import '/view_models/reset_password_model/reset_password_model.dart';

import '../../helper/local_keys.g.dart';
import '../../utils/components/empty_spacer_helper.dart';
import '../../utils/components/field_with_label.dart';

class ResetPasswordView extends StatelessWidget {
  static const routeName = 'reset_password_view';
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final rp = ResetPasswordViewModel.instance;
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
        title: Text(LocalKeys.enterEmail.capitalizeWords),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: context.dProvider.whiteColor,
                  borderRadius: BorderRadius.circular(8)),
              child: Form(
                  key: rp.emailFormKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        EmptySpaceHelper.emptyHeight(24),
                        LottieBuilder.asset(
                            "assets/animations/forgot_pass.json"),
                        EmptySpaceHelper.emptyHeight(24),
                        FieldWithLabel(
                          label: LocalKeys.email,
                          hintText: LocalKeys.enterEmail,
                          keyboardType: TextInputType.emailAddress,
                          controller: rp.emailController,
                          validator: (value) {
                            if (value!.validateEmail) {
                              return null;
                            }
                            return LocalKeys.enterValidEmailAddress;
                          },
                        ),
                        Consumer<OtpService>(
                            builder: (context, otpProvider, child) {
                          return CustomButton(
                              btText: LocalKeys.sendVerificationCode,
                              isLoading: otpProvider.loadingSendOTP,
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                rp.trySendingOTP(context);
                              });
                        })
                      ])),
            ),
          ],
        ),
      ),
    );
  }
}
