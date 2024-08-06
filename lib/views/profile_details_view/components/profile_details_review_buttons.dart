import 'package:flutter/material.dart';

import '../../../helper/local_keys.g.dart';

class ProfileDetailsReviewButtons extends StatelessWidget {
  const ProfileDetailsReviewButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 16,
          child: OutlinedButton(
            onPressed: () {},
            child: Text(LocalKeys.addAPhoto),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 16,
          child: ElevatedButton(
            onPressed: () async {},
            child: FittedBox(child: Text(LocalKeys.requestChange)),
          ),
        ),
      ],
    );
  }
}
