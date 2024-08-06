import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class OfferCoverLetter extends StatelessWidget {
  final String? coverLetter;
  const OfferCoverLetter({
    super.key,
    this.coverLetter,
  });

  @override
  Widget build(BuildContext context) {
    return coverLetter == null
        ? const SizedBox()
        : Column(
            children: [
              20.toHeight,
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: context.dProvider.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocalKeys.coverLetter,
                          style: context.titleMedium?.bold6,
                        ).hp20,
                      ],
                    ),
                    Divider(
                      color: context.dProvider.black8,
                      thickness: 2,
                      height: 24,
                    ),
                    HtmlWidget(
                      coverLetter!,
                    ).hp20,
                  ],
                ),
              ),
            ],
          );
  }
}
