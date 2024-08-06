import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/models/profile_details_model.dart';

import '../../../utils/components/image_pl_widget.dart';

class ProfileDetailsPortfolioCard extends StatelessWidget {
  final Portfolio portFolio;
  final String path;
  const ProfileDetailsPortfolioCard(
      {super.key, required this.portFolio, required this.path});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 5,
              child: SizedBox(
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: "$path/${portFolio.image}",
                    placeholder: (context, url) =>
                        const ImagePLWidget(size: 60),
                    errorWidget: (context, url, error) =>
                        const ImagePLWidget(size: 60),
                  ),
                ),
              )),
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
              flex: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    portFolio.title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.titleMedium?.bold6,
                  ),
                  8.toHeight,
                  Text(
                    "${LocalKeys.published}: ${DateFormat("MMM dd, yyyy", context.dProvider.languageSlug).format(portFolio.createdAt ?? DateTime.now())}",
                    style: context.titleSmall
                        ?.copyWith(color: context.dProvider.black5),
                  )
                ],
              )),
        ],
      ).hp20,
    );
  }
}
