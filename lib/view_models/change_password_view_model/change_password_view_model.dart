import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';

import '../../services/auth/change_password_service.dart';

class ChangePasswordViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController newPassController = TextEditingController();
  TextEditingController currentPassController = TextEditingController();
  ValueNotifier<bool> obscurePassNew = ValueNotifier(true);
  ValueNotifier<bool> obscurePassCon = ValueNotifier(true);
  ValueNotifier<bool> obscurePassCur = ValueNotifier(true);
  ValueNotifier<bool> isLoading = ValueNotifier(false);

  ChangePasswordViewModel._init();
  static ChangePasswordViewModel? _instance;
  static ChangePasswordViewModel get instance {
    _instance ??= ChangePasswordViewModel._init();
    return _instance!;
  }

  ChangePasswordViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  void tryChangingPassword(BuildContext context) async {
    final valid = formKey.currentState?.validate();
    if (valid == false) {
      return;
    }
    final cpProvider =
        Provider.of<ChangePasswordService>(context, listen: false);
    isLoading.value = true;

    await cpProvider
        .tryChangingPassword(
            oldPass: currentPassController.text,
            newPass: newPassController.text)
        .then((value) {
      if (value == true) {
        context.popFalse;
      }
    });

    isLoading.value = false;
  }
}
