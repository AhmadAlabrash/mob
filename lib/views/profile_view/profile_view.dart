import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/auth/sign_out_service.dart';
import 'package:xilancer/services/profile_info_service.dart';
import 'package:xilancer/views/account_skeleton/account_skeleton.dart';
import '../../helper/local_keys.g.dart';
import '../../helper/svg_assets.dart';
import '../../utils/components/alerts.dart';
import '../../view_models/sign_in_view/sign_in_view_model.dart';
import '../../view_models/sign_up_view/sign_up_view_model.dart';
import '../sign_in_view/sign_in_view.dart';
import '/utils/components/empty_spacer_helper.dart';

import 'components/profile_menu_list.dart';
import 'components/profile_menu_tile.dart';
import 'components/profile_view_app_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ProfileViewAppBar(),
        16.toHeight,
        Consumer<ProfileInfoService>(builder: (context, pi, child) {
          return Expanded(
            child: pi.profileInfoModel.data == null
                ? Column(
                    children: [
                      const Expanded(child: AccountSkeleton()),
                      16.toHeight,
                    ],
                  )
                : ListView(
                    padding: const EdgeInsets.only(bottom: 20),
                    children: [
                      const ProfileMenuList(),
                      EmptySpaceHelper.emptyHeight(24),
                      Container(
                        color: context.dProvider.whiteColor,
                        child: ProfileMenuTile(
                          title: LocalKeys.signOut,
                          svg: SvgAssets.logout,
                          onPress: () {
                            Alerts().confirmationAlert(
                              context: context,
                              title: LocalKeys.areYouSure,
                              buttonText: LocalKeys.signOut,
                              onConfirm: () async {
                                await Provider.of<SignOutService>(context,
                                        listen: false)
                                    .trySignOut()
                                    .then((v) {
                                  if (v == true) {
                                    Provider.of<ProfileInfoService>(context,
                                            listen: false)
                                        .reset();
                                    context.popFalse;
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        }),
      ],
    );
  }
}
