import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/order_details_service.dart';
import 'package:xilancer/view_models/my_order_details_view_model/my_order_details_view_model.dart';
import 'package:xilancer/views/my_order_details_view/components/order_details_description.dart';
import 'package:xilancer/views/my_order_details_view/components/order_details_milestons.dart';
import 'package:xilancer/views/my_order_details_view/components/order_details_work_submit.dart';

import '../../../view_models/fix_price_job_details_view_model/fix_price_job_details_view_model.dart';
import 'job_details_proposals.dart';

class JobDetailsTabs extends StatelessWidget {
  final orderHaveMilestone;
  const JobDetailsTabs({super.key, this.orderHaveMilestone = false});

  @override
  Widget build(BuildContext context) {
    final jdm = FixPriceJobDetailsViewModel.instance;
    return ValueListenableBuilder(
      valueListenable: jdm.selectedTitleIndex,
      builder: (context, value, child) => JobDetailsProposals(tabIndex: value),
    );
  }
}
