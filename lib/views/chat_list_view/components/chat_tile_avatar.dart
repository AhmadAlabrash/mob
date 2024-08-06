import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xilancer/helper/image_assets.dart';

import '/helper/extension/context_extension.dart';
import '../../../utils/components/profile_avatar_text.dart';

class ChatTileAvatar extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final double? size;
  final placeHolderImage;
  final errorImage;
  final color;
  const ChatTileAvatar({
    required this.name,
    this.imageUrl,
    this.size,
    this.placeHolderImage,
    this.errorImage,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sizeValue = size ?? 60.0;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: context.dProvider.whiteColor, shape: BoxShape.circle),
      child: SizedBox(
        height: sizeValue,
        width: sizeValue,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(sizeValue / 2),
          child: imageUrl.toString().endsWith(".svg")
              ? SvgPicture.network(imageUrl!)
              : CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: imageUrl ?? '',
                  placeholder: (context, url) {
                    return placeHolderImage != null
                        ? Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: context.dProvider.whiteColor,
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/$placeHolderImage.png"),
                                    opacity: .5)),
                          )
                        : ProfileAvatarText(
                            profileName: name,
                            fontSize: sizeValue / 4,
                            color: color,
                          );
                  },
                  errorWidget: (context, url, error) {
                    return placeHolderImage != null
                        ? PLWidget(
                            errorImage: errorImage,
                            placeHolderImage: placeHolderImage,
                          )
                        : ProfileAvatarText(
                            color: color,
                            profileName: name,
                            fontSize: sizeValue / 4,
                          );
                  },
                ),
        ),
      ),
    );
  }
}

class PLWidget extends StatelessWidget {
  const PLWidget({
    super.key,
    this.errorImage,
    this.placeHolderImage,
  });

  final String? errorImage;
  final String? placeHolderImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                  "assets/images/${errorImage ?? placeHolderImage ?? ImageAssets.loadingImage}.png"),
              opacity: .5)),
    );
  }
}
