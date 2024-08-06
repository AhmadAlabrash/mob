import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/phone_field.dart';
import 'package:xilancer/services/auth/otp_service.dart';
import 'package:xilancer/services/auth/sign_up_service.dart';
import 'package:xilancer/views/onboarding_view/onboarding_view.dart';
import 'package:xilancer/views/reset_password/enter_otp_view.dart';

import '../../helper/constant_helper.dart';
import '../../helper/local_keys.g.dart';
import '../../services/chat_credential_service.dart';
import '../../services/profile_info_service.dart';

class SignUpViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  final ValueNotifier obscurePassNew = ValueNotifier<bool>(true);
  final ValueNotifier obscurePassConfirm = ValueNotifier<bool>(true);
  final ValueNotifier loading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> tacPpAccept = ValueNotifier(false);
  final ValueNotifier<Phone?> phone = ValueNotifier(null);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpViewModel._init();
  static SignUpViewModel? _instance;
  static SignUpViewModel get instance {
    _instance ??= SignUpViewModel._init();
    return _instance!;
  }

  static get dispose {
    _instance = null;
    return true;
  }

  passwordValidator(BuildContext context, value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return LocalKeys.passwordValidateText;
    }
    return null;
  }

  emailUsernameValidator(value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return asProvider.getString(LocalKeys.emailUsernameValidateText);
    }
    return null;
  }

  signUp(BuildContext context) async {
    final isValid = formKey.currentState?.validate();
    if (isValid == false) {
      return;
    }
    if (!tacPpAccept.value) {
      LocalKeys.pleaseAgreeWitheTacPP.showToast();
      return;
    }

    final su = Provider.of<SignUpService>(context, listen: false);
    loading.value = true;
    su
        .trySignUp(
            firstName: firstNameController.text,
            lastName: lastNameController.text,
            userName: usernameController.text,
            email: emailController.text,
            phone: phoneController.text,
            password: passwordController.text)
        .then((value) {
      if (value == true) {
        context.toPage(
            EnterOtpView(
              su.emailToken,
              email: emailController.text,
              fromRegister: true,
            ), then: (otp) async {
          if (su.emailToken == otp) {
            await su.tryConfirmingEmail(otpCode: otp).then((value) async {
              if (value == true) {
                setToken(su.token);
                Provider.of<ChatCredentialService>(context, listen: false)
                    .fetchCredentials();
                await Provider.of<ProfileInfoService>(context, listen: false)
                    .fetchProfileInfo();
                context.popTrue;
                context.popTrue;
                loading.value = false;
                dispose;
                return;
              } else {
                loading.value = false;
              }
            });
          } else {
            loading.value = false;
          }
        });
      } else {
        loading.value = false;
      }
    });
  }
}
