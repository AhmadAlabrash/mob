import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';

class MyOrderId extends StatelessWidget {
  final id;
  const MyOrderId({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          id.toString(),
          style: context.titleSmall?.bold6
              .copyWith(color: context.dProvider.primaryColor),
        ),
        6.toWidth,
      ],
    );
  }
}
