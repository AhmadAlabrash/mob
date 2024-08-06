import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xilancer/view_models/sign_up_view/sign_up_view_model.dart';
import 'package:xilancer/views/sign_up_view/sign_up_view.dart';

import '/helper/extension/context_extension.dart';
import '/helper/local_keys.g.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        softWrap: true,
        text: TextSpan(
            text: LocalKeys.doNotHaveAccount,
            style: TextStyle(
              color: context.dProvider.black5,
              fontWeight: FontWeight.w600,
            ),
            children: [
              TextSpan(
                  text: '   ',
                  style: TextStyle(color: context.dProvider.black5)),
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      FocusScope.of(context).unfocus();
                      SignUpViewModel.dispose;
                      context.toNamed(SignUpView.routeName);
                    },
                  text: LocalKeys.signUp0,
                  style: TextStyle(color: context.dProvider.secondaryColor)),
            ]),
      ),
    );
  }
}
