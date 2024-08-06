import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/job_list_service.dart.dart';
import 'package:xilancer/services/message_notification_count_service.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/views/home_view/components/home_job_create.dart';
import 'package:xilancer/views/fixed_price_job_details_view/components/job_card.dart';
import 'package:xilancer/views/home_view/components/jobs_search_field.dart';
import '../../view_models/home_view_model/home_view_model.dart';
import '../projects_list/projects_list.dart';
import '/utils/components/custom_refresh_indicator.dart';

import '../home_view/components/home_app_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final hvm = HomeViewModel.instance;
    Provider.of<MessageNotificationCountService>(context, listen: false)
        .fetchMN();
    return Column(
      children: [
        const HomeAppBar(),
        Expanded(
          child: Container(
            color: context.dProvider.black9,
            child: const ProjectsList(),
          ),
        ),
      ],
    );
  }
}
