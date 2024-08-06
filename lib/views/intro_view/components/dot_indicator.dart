import 'package:flutter/material.dart';
import '/helper/extension/context_extension.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;
  final int dotCount;
  const DotIndicator(this.isActive, {super.key, this.dotCount = 3});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        height: 8,
        width: isActive ? 40 : 12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isActive
              ? context.dProvider.whiteColor
              : context.dProvider.whiteColor.withOpacity(.4),
        ),
      ),
    );
  }
}
