import 'package:flutter/material.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/view_models/change_password_view_model/change_password_view_model.dart';
import 'package:xilancer/views/profile_edit_view/profile_edit_view.dart';
import 'package:xilancer/views/wallet_view/wallet_view.dart';
import '../../profile_view/components/profile_menu_tile.dart';
import '../../support_ticket_list_view/support_ticket_list_view.dart';
import '/helper/extension/context_extension.dart';
import '/helper/local_keys.g.dart';
import '/views/change_password_view/change_password_view.dart';

class ProfileSettingMenuList extends StatelessWidget {
  const ProfileSettingMenuList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfileMenuTile(
          title: LocalKeys.editProfile,
          svg: SvgAssets.userSquare,
          onPress: () {
            context.toNamed(ProfileEditView.routeName);
          },
        ),
        ProfileMenuTile(
          title: LocalKeys.supportTicket,
          svg: SvgAssets.support,
          onPress: () {
            context.toNamed(SupportTicketListView.routeName);
          },
        ),
        ProfileMenuTile(
          title: LocalKeys.changePassword,
          svg: SvgAssets.lock,
          onPress: () {
            ChangePasswordViewModel.dispose;
            context.toNamed(ChangePasswordView.routeName);
          },
        ),
        ProfileMenuTile(
          title: LocalKeys.wallet,
          svg: SvgAssets.wallet,
          onPress: () {
            context.toNamed(WalletView.routeName);
          },
        ),
      ],
    );
  }
}
