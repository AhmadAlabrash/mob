import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/profile_info_service.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/navigation_pop_icon.dart';
import 'package:xilancer/views/profile_settings_view/components/profile_setting_info.dart';
import 'package:xilancer/views/profile_settings_view/components/profile_setting_menu_list.dart';

class ProfileSettingsView extends StatelessWidget {
  static const routeName = 'profile_settings_view';
  const ProfileSettingsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationPopIcon(),
          title: Text(LocalKeys.profileSettings),
        ),
        body: CustomRefreshIndicator(
          onRefresh: () async {
            await Provider.of<ProfileInfoService>(context, listen: false)
                .fetchProfileInfo();
          },
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            children: [
              const ProfileSettingInfo(),
              2.toHeight,
              const ProfileSettingMenuList(),
            ],
          ),
        ));
  }
}
