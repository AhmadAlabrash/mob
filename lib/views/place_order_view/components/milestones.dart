import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/views/place_order_view/components/milestone_card.dart';
import 'package:xilancer/views/place_order_view/components/milestone_sheet.dart';

import '../../../helper/local_keys.g.dart';
import '../../../utils/components/field_label.dart';
import '../../../utils/components/select_date_fl.dart';
import '../../../view_models/place_order_view_model/place_order_view_model.dart';
import '../../conversation_view/components/send_offer_sheet.dart';

class Milestones extends StatelessWidget {
  const Milestones({super.key});

  @override
  Widget build(BuildContext context) {
    final pom = PlaceOrderViewViewModel.instance;
    return ValueListenableBuilder(
      valueListenable: pom.milestones,
      builder: (context, milestones, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...milestones.map((e) => MilestoneCard(milestone: e)).toList(),
            OutlinedButton.icon(
                onPressed: () {
                  pom.resetMilestoneSheet();
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isDismissible: false,
                    isScrollControlled: true,
                    builder: (context) => const MilestoneSheet(),
                  );
                },
                icon: const Icon(Icons.add_rounded),
                label: Text(LocalKeys.addMilestone)),
            16.toHeight,
          ],
        );
      },
    );
  }
}
