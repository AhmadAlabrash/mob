import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

extension SizedBoxExtension on int {
  Widget get toHeight {
    return SizedBox(
      height: toDouble(),
    );
  }

  Widget get toWidth {
    return SizedBox(
      width: toDouble(),
    );
  }
}

extension CurrencyExtension on double {
  String get cur {
    return toStringAsFixed(2).cur;
  }
}
