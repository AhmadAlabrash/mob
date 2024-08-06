import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

class PriceInfoTile extends StatelessWidget {
  final price;
  final status;
  final color;
  const PriceInfoTile({super.key, this.price, this.status, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$price".cur,
                style: context.titleMedium?.copyWith().bold6,
              ),
              Text(
                "$status",
                style: context.titleSmall
                    ?.copyWith(color: context.dProvider.black5),
              )
            ],
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.info_outline_rounded,
                color: context.dProvider.black5,
              ))
        ],
      ),
    );
  }
}
