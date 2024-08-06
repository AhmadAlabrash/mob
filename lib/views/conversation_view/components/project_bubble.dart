import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/utils/components/custom_network_image.dart';

class ProjectBubble extends StatelessWidget {
  final String title;
  final String? imageUrl;
  final bool senderFromWeb;
  const ProjectBubble({
    super.key,
    required this.title,
    this.imageUrl,
    required this.senderFromWeb,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width - 84,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(12),
          bottomRight: const Radius.circular(12),
          topRight: senderFromWeb
              ? const Radius.circular(12)
              : const Radius.circular(0),
          topLeft: senderFromWeb
              ? const Radius.circular(0)
              : const Radius.circular(12),
        ),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        children: [
          CustomNetworkImage(
            height: 134,
            width: double.infinity,
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            radius: 12.0,
          ),
          4.toHeight,
          Text(
            title,
            style: context.titleMedium,
          ),
        ],
      ),
    );
  }
}
