import 'package:flutter/material.dart';
import '/views/reset_password/reset_password_view.dart';
import '/helper/extension/context_extension.dart';
import '/helper/local_keys.g.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: context.width / 2),
      child: FittedBox(
        child: TextButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            context.toPage(const ResetPasswordView());
          },
          child: Text(
            LocalKeys.forgotPassword,
            style: context.titleMedium!.copyWith(
              color: context.dProvider.secondaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
