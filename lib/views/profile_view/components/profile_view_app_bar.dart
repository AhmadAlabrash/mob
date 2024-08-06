import 'package:flutter/material.dart';
import '/helper/local_keys.g.dart';

class ProfileViewAppBar extends StatelessWidget {
  const ProfileViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 0,
      leading: const SizedBox(),
      title: Text(
        LocalKeys.profile,
      ),
    );
  }
}
