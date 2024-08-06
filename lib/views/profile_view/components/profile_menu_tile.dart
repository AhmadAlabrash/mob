import 'package:flutter/material.dart';
import '../../../helper/extension/int_extension.dart';
import '/helper/extension/context_extension.dart';
import '/helper/extension/string_extension.dart';

class ProfileMenuTile extends StatelessWidget {
  final String title;
  final String svg;
  final void Function() onPress;
  const ProfileMenuTile({
    required this.title,
    required this.svg,
    required this.onPress,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 52,
        margin: const EdgeInsets.only(bottom: 2),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: context.dProvider.whiteColor,
        ),
        child: Row(children: [
          svg.toSVGSized(20),
          12.toWidth,
          Text(
            title,
            style: context.titleMedium?.bold6
                .copyWith(color: context.dProvider.black4),
          ),
        ]),
      ),
    );
  }
}
