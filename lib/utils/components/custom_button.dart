import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';

import 'custom_preloader.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String btText;
  final bool isLoading;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.btText,
    required this.isLoading,
    this.height = 40,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed == null
            ? null
            : isLoading
                ? () {}
                : () {
                    onPressed!();
                  },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return (backgroundColor ?? context.dProvider.primaryColor)
                  .withOpacity(.7);
            }
            if (states.contains(MaterialState.pressed) || isLoading) {
              return context.dProvider.blackColor;
            }
            return backgroundColor ?? context.dProvider.primaryColor;
          }),
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.disabled)) {
              return context.dProvider.black5;
            }
            if (states.contains(MaterialState.pressed)) {
              return foregroundColor ?? context.dProvider.whiteColor;
            }
            return foregroundColor ?? context.dProvider.whiteColor;
          }),
        ),
        child: isLoading
            ? SizedBox(
                height: height! - 4,
                child: const CustomPreloader(
                  whiteColor: true,
                ),
              )
            : FittedBox(
                child: Text(
                  btText,
                  maxLines: 1,
                ),
              ),
      ),
    );
  }
}
