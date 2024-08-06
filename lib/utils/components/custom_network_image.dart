import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';

import '../../helper/image_assets.dart';

class CustomNetworkImage extends StatelessWidget {
  final double? radius;
  final double? height;
  final double? width;
  final String? name;
  final BoxFit? fit;
  final String? imageUrl;
  final String? filePath;
  final bool userPreloader;
  final Widget? errorWidget;
  const CustomNetworkImage(
      {super.key,
      this.radius,
      this.height,
      this.width,
      this.fit,
      this.name,
      this.filePath,
      this.imageUrl,
      this.errorWidget,
      this.userPreloader = false});

  @override
  Widget build(BuildContext context) {
    final plImage = Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ImageAssets.loadingImage.toAsset, opacity: .5)),
    );
    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius ?? 0),
        child: filePath != null
            ? Image.file(
                File(filePath!),
                fit: fit,
              )
            : Image.network(
                imageUrl ?? '',
                fit: fit,
                errorBuilder: (context, error, stackTrace) {
                  if (name != null) {
                    return errorWidget ??
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: context.dProvider.primaryColor,
                          alignment: Alignment.center,
                          child: Text(
                            name!.substring(0, 2).toUpperCase(),
                            style: context.titleMedium?.copyWith(
                                color: context.dProvider.whiteColor,
                                fontSize: (radius ?? 60) / 1.5,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                  }
                  return plImage;
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (!((loadingProgress?.expectedTotalBytes) ==
                          loadingProgress?.cumulativeBytesLoaded) ||
                      loadingProgress != null) {
                    return userPreloader
                        ? const SizedBox(
                            height: 36,
                            width: 150,
                            child: CustomPreloader(
                              whiteColor: true,
                            ))
                        : plImage;
                  }
                  return child;
                },
              ),
      ),
    );
  }
}
