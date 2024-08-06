import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class MaxAmountSuffix extends StatelessWidget {
  const MaxAmountSuffix({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FittedBox(
          child: Row(
            children: [
              Container(
                height: 28,
                width: 1,
                color: context.dProvider.black8,
              ),
              6.toWidth,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.dProvider.black9,
                ),
                child: Text(
                  "${LocalKeys.max}. ${"500".cur}",
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.black4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
