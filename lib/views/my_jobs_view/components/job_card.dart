import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/views/fixed_price_job_details_view/fixed_price_job_details_view.dart';
import 'package:xilancer/views/my_jobs_view/components/my_job_card_buttons.dart';

class JobCard extends StatelessWidget {
  final id;
  final title;
  final createDate;
  final expertise;
  final price;
  final priceType;
  final jobStatus;
  final proposalCount;

  const JobCard({
    super.key,
    this.id,
    required this.title,
    required this.createDate,
    required this.expertise,
    required this.price,
    required this.priceType,
    required this.proposalCount,
    this.jobStatus,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: context.dProvider.whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                color: context.dProvider.whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 12,
                    runSpacing: 8,
                    children: [
                      Text(
                        "#$id",
                        style: context.titleMedium
                            ?.copyWith(color: context.dProvider.primaryColor)
                            .bold6,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: context.dProvider.yellowColor,
                            )),
                        child: Text(
                          priceType,
                          style: context.titleSmall
                              ?.copyWith(color: context.dProvider.yellowColor)
                              .bold6,
                        ),
                      )
                    ],
                  ),
                  6.toHeight,
                  Text(
                    title,
                    style: context.titleMedium?.bold6,
                  ),
                  6.toHeight,
                  Wrap(
                    spacing: 12,
                    runSpacing: 6,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: context.dProvider.black7,
                            )),
                        child: Text(
                          jobStatus ? LocalKeys.open : LocalKeys.off,
                          style: context.titleSmall
                              ?.copyWith(color: context.dProvider.black5)
                              .bold6,
                        ),
                      ),
                      Text(
                        "${DateFormat("MMM dd,yyyy").format(createDate ?? DateTime.now())} .",
                        style: context.titleSmall,
                      ),
                      Text(expertise + " .",
                          style: context.titleSmall
                              ?.copyWith(color: context.dProvider.primaryColor)
                              .bold6),
                      Text(
                        "${LocalKeys.proposals}: $proposalCount",
                        style: context.titleSmall,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            2.toHeight,
            MyJobCardButtons(
              id: id,
              title: title,
              jobStatus: jobStatus,
            ),
          ],
        ),
      ),
    );
  }

  String formatDateTime(DateTime date) {
    DateTime now = DateTime.now();
    Duration difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'moments ago';
    } else if (difference.inMinutes < 60) {
      int minutes = difference.inMinutes;
      return '$minutes minute${minutes > 1 ? 's' : ''} ago';
    } else if (difference.inHours < 24) {
      int hours = difference.inHours;
      return '$hours hour${hours > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 30) {
      int days = difference.inDays;
      return '$days day${days > 1 ? 's' : ''} ago';
    } else if (difference.inDays < 365) {
      int months = (now.year - date.year) * 12 + (now.month - date.month);
      return '$months month${months > 1 ? 's' : ''} ago';
    } else {
      int years = now.year - date.year;
      return '$years year${years > 1 ? 's' : ''} ago';
    }
  }
}

class Infos extends StatelessWidget {
  const Infos({
    super.key,
    required this.svgIcon,
    required this.text,
  });

  final text;
  final svgIcon;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [svgIcon, 6.toWidth, Text(text)],
      ),
    );
  }
}
