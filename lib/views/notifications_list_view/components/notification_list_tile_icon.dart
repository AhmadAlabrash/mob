import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '/helper/extension/context_extension.dart';
import '../../../utils/components/profile_avatar_text.dart';

class NotificationListTileIcon extends StatelessWidget {
  final String name;
  final String? imageUrl;
  final size;
  final placeHolderImage;
  final errorImage;
  const NotificationListTileIcon({
    required this.name,
    this.imageUrl,
    this.size,
    this.placeHolderImage,
    this.errorImage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final sizeValue = size ?? 60.0;
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: context.dProvider.primary05, shape: BoxShape.circle),
      child: SizedBox(
        height: sizeValue,
        width: sizeValue,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(sizeValue / 2),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: imageUrl ?? '',
            placeholder: (context, url) {
              return placeHolderImage != null
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/$placeHolderImage.png"),
                                    opacity: .5)),
                          ),
                        ),
                      ],
                    )
                  : ProfileAvatarText(profileName: name);
            },
            errorWidget: (context, url, error) {
              return placeHolderImage != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/${errorImage ?? placeHolderImage}.png"),
                                opacity: .5)),
                      ),
                    )
                  : ProfileAvatarText(profileName: name);
            },
          ),
        ),
      ),
    );
  }
}
