import 'package:flutter/material.dart';

import '../../../helper/extension/context_extension.dart';
import '../../../helper/local_keys.g.dart';
import '../../notifications_list_view/components/notification_list_tile.dart';

class ProposalStatus extends StatelessWidget {
  const ProposalStatus({
    super.key,
    required this.rating,
    required this.ratingCount,
    required this.hired,
    required this.rejected,
    required this.jobCompleteCount,
    required this.submitDate,
  });

  final ratingCount;
  final num rating;
  final hired;
  final rejected;
  final jobCompleteCount;
  final submitDate;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: context.dProvider.yellowColor.withOpacity(0.05),
          ),
          child: FittedBox(
            child: Row(
              children: [
                if (ratingCount > 0)
                  Icon(Icons.star_rounded,
                      size: 16, color: context.dProvider.yellowColor),
                Text(
                  ratingCount > 0
                      ? " ${rating.toStringAsFixed(1)} ($ratingCount)"
                      : LocalKeys.noReview,
                  style: context.titleSmall
                      ?.copyWith(color: context.dProvider.yellowColor),
                ),
              ],
            ),
          ),
        ),
        if (hired)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.dProvider.primaryColor,
                )),
            child: Text(
              LocalKeys.hired,
              style: context.titleSmall
                  ?.copyWith(color: context.dProvider.primaryColor),
            ),
          ),
        if (rejected)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: context.dProvider.warningColor,
                )),
            child: Text(
              LocalKeys.rejected,
              style: context.titleSmall
                  ?.copyWith(color: context.dProvider.warningColor),
            ),
          ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.dProvider.greenColor.withOpacity(.1),
          ),
          child: Text(
            jobCompleteCount <= 0
                ? LocalKeys.noOrder
                : "$jobCompleteCount ${LocalKeys.ordersCompleted}",
            style: context.titleSmall
                ?.copyWith(color: context.dProvider.greenColor),
          ),
        ),
        Text(
          formatDateTime(submitDate),
          style: context.titleSmall?.copyWith(color: context.dProvider.black5),
        ),
      ],
    );
  }
}
