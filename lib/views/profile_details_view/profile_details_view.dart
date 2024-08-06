import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/profile_details_service.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/view_models/profile_details_view_model/profile_details_view_model.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_basic_info.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_earning_data.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_education.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_experience.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_portfolio.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_project_catelogue.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_reviews.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_skeleton.dart';
import 'package:xilancer/views/profile_details_view/components/profile_details_skills.dart';

class ProfileDetailsView extends StatelessWidget {
  static const routeName = 'profile_details_view';
  final username;
  final bool userActiveStatus;

  const ProfileDetailsView({
    super.key,
    required this.username,
    required this.userActiveStatus,
  });
  @override
  Widget build(BuildContext context) {
    final pdm = ProfileDetailsViewModel.instance;
    final pdProvider =
        Provider.of<ProfileDetailsService>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationPopIcon(),
          title: Text(
            LocalKeys.profile,
          ),
          actions: const [],
        ),
        body: CustomRefreshIndicator(
          onRefresh: () async {
            await pdProvider.fetchProfileDetails();
          },
          child: CustomFutureWidget(
            function: pdProvider.shouldAutoFetch(username)
                ? pdProvider.fetchProfileDetails(username: username)
                : null,
            shimmer: const ProfileDetailsSkeleton(),
            child:
                Consumer<ProfileDetailsService>(builder: (context, pd, child) {
              return Scrollbar(
                controller: pdm.controller,
                child: ListView(
                  controller: pdm.controller,
                  padding: const EdgeInsets.all(20),
                  children: [
                    ProfileDetailsBasicInfo(userActiveStatus: userActiveStatus),
                    20.toHeight,
                    ProfileDetailsEarningData(pd: pd),
                    ProfileDetailsExperience(pd: pd),
                    ProfileDetailsEducation(pd: pd),
                    ProfileDetailsSkills(pd: pd),
                    ProfileDetailsReviews(pd: pd),
                    ProfileDetailsPortfolio(pd: pd),
                    ProfileViewProjectCatalogue(pd: pd),
                  ],
                ),
              );
            }),
          ),
        ));
  }
}
