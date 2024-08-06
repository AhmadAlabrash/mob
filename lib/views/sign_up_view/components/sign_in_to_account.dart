import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '/helper/extension/context_extension.dart';
import '/helper/local_keys.g.dart';

class SignInToAccount extends StatelessWidget {
  const SignInToAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        softWrap: true,
        text: TextSpan(
            text: LocalKeys.haveAccount,
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
                      Navigator.pop(context);
                    },
                  text: LocalKeys.signIn0,
                  style: TextStyle(color: context.dProvider.secondaryColor)),
            ]),
      ),
    );
  }
}
