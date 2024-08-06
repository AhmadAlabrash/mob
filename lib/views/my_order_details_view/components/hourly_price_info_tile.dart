import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

class HourlyPriceInfoTile extends StatelessWidget {
  final price;
  final priceNote;
  final status;
  final color;
  final isPrice;
  final String desc;
  const HourlyPriceInfoTile(
      {super.key,
      this.price,
      this.status,
      this.color,
      this.priceNote,
      this.isPrice = true,
      required this.desc});

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
              RichText(
                  text: TextSpan(
                      text: isPrice ? "$price".cur : "$price",
                      style: context.titleMedium?.copyWith().bold6,
                      children: [
                    TextSpan(
                      text: priceNote,
                      style: context.titleSmall
                          ?.copyWith(color: context.dProvider.black5),
                    )
                  ])),
              Text(
                "$status",
                style: context.titleSmall
                    ?.copyWith(color: context.dProvider.black5),
              )
            ],
          ),
          IconButton(
              onPressed: () {
                desc.showToast();
              },
              icon: Icon(
                Icons.info_outline_rounded,
                color: context.dProvider.black5,
              ))
        ],
      ),
    );
  }
}
