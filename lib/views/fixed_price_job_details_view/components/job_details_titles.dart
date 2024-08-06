import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/job_details_service.dart';
import 'package:xilancer/services/order_details_service.dart';
import 'package:xilancer/view_models/fix_price_job_details_view_model/fix_price_job_details_view_model.dart';

import '../../../helper/local_keys.g.dart';

class JobDetailsTitles extends StatelessWidget {
  final orderHaveMilestone;
  const JobDetailsTitles({super.key, this.orderHaveMilestone = false});

  @override
  Widget build(BuildContext context) {
    final jdm = FixPriceJobDetailsViewModel.instance;
    return Consumer<JobDetailsService>(builder: (context, jd, child) {
      List titles = [
        LocalKeys.proposals,
        LocalKeys.hired,
        LocalKeys.shortListed,
        LocalKeys.interviewed,
      ];
      List counts = [
        jd.jobDetailsModel.jobDetails?.jobProposals?.length ?? 0,
        jd.hiredCount,
        jd.shortListCount,
        jd.interviewedCount,
      ];
      return ValueListenableBuilder(
        valueListenable: jdm.selectedTitleIndex,
        builder: (context, value, child) => SizedBox(
          height: 40,
          child: ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      jdm.selectedTitleIndex.value = index;
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: value == index
                                      ? context.dProvider.primaryColor
                                      : context.dProvider.black5))),
                      child: Text(
                        titles[index] + " (${counts[index]})",
                        style: context.titleSmall?.copyWith(
                            color: value == index
                                ? context.dProvider.primaryColor
                                : context.dProvider.black4),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => 4.toWidth,
              itemCount: titles.length),
        ),
      );
    });
  }
}
