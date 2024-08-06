import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/services/account_delete_service.dart';
import 'package:xilancer/views/my_jobs_view/my_jobs_view.dart';
import 'package:xilancer/views/my_offers_view/my_offers_view.dart';
import 'package:xilancer/views/profile_settings_view/profile_settings_view.dart';

import '../../../services/profile_info_service.dart';
import '../../../utils/components/alerts.dart';
import '../../create_project_view/create_job_view.dart';
import '/helper/extension/context_extension.dart';
import '/helper/local_keys.g.dart';

import 'profile_menu_tile.dart';

class ProfileMenuList extends StatelessWidget {
  const ProfileMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ProfileMenuTile(
            title: LocalKeys.postAJob,
            svg: SvgAssets.addCircle,
            onPress: () {
              context.toPage(const CreateJobView());
            },
          ),
          ProfileMenuTile(
            title: LocalKeys.myJobs,
            svg: SvgAssets.clipboardText,
            onPress: () {
              context.toNamed(MyJobsView.routeName);
            },
          ),
          ProfileMenuTile(
            title: LocalKeys.myOffers,
            svg: SvgAssets.task,
            onPress: () {
              context.toNamed(MyOffersView.routeName);
            },
          ),
          ProfileMenuTile(
            title: LocalKeys.profileSettings0,
            svg: SvgAssets.setting,
            onPress: () {
              context.toNamed(ProfileSettingsView.routeName);
            },
          ),
          ProfileMenuTile(
            title: LocalKeys.deleteAccount0,
            svg: SvgAssets.trash,
            onPress: () {
              Alerts().confirmationAlert(
                context: context,
                title: LocalKeys.areYouSure,
                buttonText: LocalKeys.delete,
                onConfirm: () async {
                  await Provider.of<AccountDeleteService>(context,
                          listen: false)
                      .tryAccountDelete()
                      .then((value) {
                    if (value == true) {
                      Provider.of<ProfileInfoService>(context, listen: false)
                          .reset();
                      context.popFalse;
                    }
                  });
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
