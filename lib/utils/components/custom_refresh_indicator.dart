import 'package:flutter/material.dart';

import '/helper/extension/context_extension.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final child;
  final onRefresh;
  const CustomRefreshIndicator({super.key, this.child, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        backgroundColor: context.dProvider.primary40,
        color: context.dProvider.whiteColor,
        child: child,
        onRefresh: onRefresh);
  }
}
