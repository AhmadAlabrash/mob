import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';

import '../../helper/local_keys.g.dart';
import '../../utils/components/alerts.dart';
import '../../views/sign_in_view/sign_in_view.dart';

class DeleteAccountViewModel {
  ValueNotifier passVN = ValueNotifier(true);
  TextEditingController passController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  DeleteAccountViewModel._init();
  static DeleteAccountViewModel? _instance;
  static DeleteAccountViewModel get instance {
    _instance ??= DeleteAccountViewModel._init();
    return _instance!;
  }

  DeleteAccountViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  tryDeletingAccount(BuildContext context) {
    final validForm = formKey.currentState?.validate() ?? false;
    if (!validForm) {
      return;
    }
    Alerts().confirmationAlert(
      context: context,
      title: LocalKeys.areYouSure,
      buttonText: LocalKeys.delete,
      onConfirm: () async {
        await Future.delayed(const Duration(seconds: 2));
        context.paru(const SignInView());
      },
    );
  }
}
