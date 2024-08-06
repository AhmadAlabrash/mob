import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '/helper/extension/context_extension.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.title,
    this.physics,
    this.margin,
  });

  final String title;
  final physics;
  final margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: context.dProvider.whiteColor,
          borderRadius: BorderRadius.circular(8)),
      child: ListView(
        physics: physics,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.asset(
                "assets/animations/empty_list.json",
                width: context.width / 1.7,
                height: context.width / 1.7,
                fit: BoxFit.cover,
                repeat: false,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: context.titleSmall
                        ?.copyWith(color: context.dProvider.black5)
                        .bold6,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
