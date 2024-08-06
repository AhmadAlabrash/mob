import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/auth/sign_up_service.dart';
import 'package:xilancer/services/profile_info_service.dart';
import '../../services/auth/sign_in_service.dart';
import '../../services/chat_credential_service.dart';
import '../../views/reset_password/enter_otp_view.dart';
import '/helper/extension/context_extension.dart';

import '/helper/local_keys.g.dart';
import '../../helper/constant_helper.dart';

class SignInViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  final ValueNotifier obscurePass = ValueNotifier<bool>(true);
  final ValueNotifier rememberPass = ValueNotifier<bool>(true);
  final ValueNotifier loading = ValueNotifier<bool>(false);
  final TextEditingController emailUsernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignInViewModel._init();
  static SignInViewModel? _instance;
  static SignInViewModel get instance {
    _instance ??= SignInViewModel._init();
    return _instance!;
  }

  static get dispose {
    _instance = null;
    return true;
  }

  passwordValidator(BuildContext context, value) {
    if (value == null ||
        value.isEmpty ||
        value.trim().isEmpty ||
        value.length < 6) {
      return LocalKeys.passwordValidateText;
    }
    return null;
  }

  setUserInfo({email, pass}) async {
    sPref?.setString("user-email", email ?? "");
    sPref?.setString("user-pass", pass ?? "");
    sPref?.setBool("user-remember", rememberPass.value);
  }

  emailUsernameValidator(value) {
    if (value == null || value.isEmpty || value.trim().isEmpty) {
      return asProvider.getString(LocalKeys.emailUsernameValidateText);
    }
    return null;
  }

  initSavedInfo() {
    emailUsernameController.text = sPref?.getString("user-email") ?? "";
    passwordController.text = sPref?.getString("user-pass") ?? "";
    rememberPass.value = sPref?.getBool("user-remember") ?? true;
  }

  signIn(BuildContext context) async {
    final isValid = formKey.currentState?.validate();

    if (isValid == false) {
      return;
    }
    context.unFocus;
    if (rememberPass.value == true) {
      setUserInfo(
          email: emailUsernameController.text, pass: passwordController.text);
    } else {
      setUserInfo();
    }
    loading.value = true;
    final siProvider = Provider.of<SignInService>(context, listen: false);
    final piProvider = Provider.of<ProfileInfoService>(context, listen: false);
    siProvider
        .trySignIn(
            emailUsername: emailUsernameController.text,
            password: passwordController.text)
        .then((value) async {
      final si = Provider.of<SignInService>(context, listen: false);
      if (value == true) {
        setToken(si.token);
        Provider.of<ChatCredentialService>(context, listen: false)
            .fetchCredentials();
        await piProvider.fetchProfileInfo();
        dispose;
        context.popFalse;
      } else if (value == false) {
        final su = Provider.of<SignUpService>(context, listen: false);
        context.toPage(
            EnterOtpView(
              si.emailToken,
              email: si.email,
              fromRegister: true,
            ), then: (otp) async {
          if (si.emailToken == otp) {
            await su
                .tryConfirmingEmail(otpCode: otp, id: si.userId)
                .then((value) async {
              if (value == true) {
                setToken(si.token);
                Provider.of<ChatCredentialService>(context, listen: false)
                    .fetchCredentials();
                await piProvider.fetchProfileInfo();
                context.popFalse;
                loading.value = false;

                dispose;
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
