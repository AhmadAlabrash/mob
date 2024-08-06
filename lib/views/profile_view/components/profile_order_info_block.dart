import 'package:flutter/material.dart';
import '/helper/extension/context_extension.dart';

class ProfileOrderInfoBlock extends StatelessWidget {
  final value;
  final title;
  const ProfileOrderInfoBlock({
    required this.value,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.titleLarge?.bold,
        ),
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: context.titleSmall?.bold5,
        ),
      ],
    );
  }
}
