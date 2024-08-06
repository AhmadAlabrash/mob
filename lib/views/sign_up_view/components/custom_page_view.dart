import 'package:flutter/material.dart';

import 'size_reporting_widget.dart';

class ExpandablePageView extends StatelessWidget {
  final List<Widget> children;
  final pageController;
  final List heights;
  final index;
  final onChangedFunction;
  final onSizeChangeFunction;

  const ExpandablePageView({
    Key? key,
    this.index,
    required this.heights,
    this.onChangedFunction,
    this.onSizeChangeFunction,
    required this.children,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      curve: Curves.easeInOutCubic,
      duration: const Duration(milliseconds: 100),
      tween: Tween<double>(begin: heights[0], end: heights[index]),
      builder: (context, value, child) => SizedBox(height: value, child: child),
      child: PageView(
        controller: pageController,
        onPageChanged: onChangedFunction,
        physics: const NeverScrollableScrollPhysics(),
        children: children
            .asMap()
            .map(
              (index, child) => MapEntry(
                index,
                OverflowBox(
                  minHeight: 0,
                  maxHeight: double.infinity,
                  alignment: Alignment.topCenter,
                  child: SizeReportingWidget(
                    onSizeChange: (value) {
                      onSizeChangeFunction(value, index);
                    },
                    child: Align(child: child),
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
