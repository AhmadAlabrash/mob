import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

class ProfileEarningTile extends StatelessWidget {
  final value;
  final String? price;
  final subtitle;
  final String svg;
  final color;

  const ProfileEarningTile(
      {super.key,
      required this.value,
      required this.price,
      required this.subtitle,
      required this.svg,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.05),
        child: svg.toSVGSized(20, color: color),
      ),
      title: Text(
        price?.cur ?? value,
        style: context.titleMedium?.bold6,
      ),
      subtitle: Text(subtitle),
    );
  }
}
