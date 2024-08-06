import 'package:flutter/material.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/empty_spacer_helper.dart';

import '../../sign_in_view/components/social_sign_in_button.dart';

class SocialSignUp extends StatelessWidget {
  const SocialSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SocialSignInButton(
          title: LocalKeys.signUpWithGoogle,
          image: "google",
          onTap: () async {},
        ),
        EmptySpaceHelper.emptyHeight(16),
        SocialSignInButton(
          title: LocalKeys.signUpWithFacebook,
          image: "facebook",
          onTap: () async {},
        ),
      ],
    );
  }
}
