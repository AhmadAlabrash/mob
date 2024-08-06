import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';

class TicketListSkeleton extends StatelessWidget {
  const TicketListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(20),
      children: List.generate(
          8,
          (index) => Column(
                children: [
                  Container(
                    height: 121,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: context.dProvider.black8),
                  ),
                  12.toHeight,
                ],
              )),
    ).shim;
  }
}
