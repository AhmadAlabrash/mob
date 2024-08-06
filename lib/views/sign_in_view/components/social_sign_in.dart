import 'package:flutter/material.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/empty_spacer_helper.dart';

import 'social_sign_in_button.dart';

class SocialSignIn extends StatelessWidget {
  const SocialSignIn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialSignInButton(
          title: LocalKeys.signInWithGoogle,
          image: "google",
          onTap: () async {},
        ),
        EmptySpaceHelper.emptyHeight(16),
        SocialSignInButton(
          title: LocalKeys.signInWithFacebook,
          image: "facebook",
          onTap: () async {},
        ),
      ],
    );
  }
}
