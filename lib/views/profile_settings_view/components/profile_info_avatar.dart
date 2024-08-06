import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/services/profile_info_service.dart';
import '../../../view_models/profile_edit_view_model.dart/profile_edit_view_model.dart';
import '/views/chat_list_view/components/chat_tile_avatar.dart';

class ProfileInfoAvatar extends StatelessWidget {
  final editing;
  const ProfileInfoAvatar({
    super.key,
    this.editing = false,
  });

  @override
  Widget build(BuildContext context) {
    final pev = ProfileEditViewModel.instance;
    return Consumer<ProfileInfoService>(builder: (context, piProvider, child) {
      return SizedBox(
        width: 100,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: pev.profileImage,
              builder: (context, value, child) => value != null && editing
                  ? CircleAvatar(
                      radius: 45,
                      backgroundColor: context.dProvider.primary40,
                      backgroundImage: FileImage(value),
                    )
                  : ChatTileAvatar(
                      name: piProvider.profileInfoModel.data?.firstName ?? "FE",
                      imageUrl: piProvider.profileInfoModel.data?.image,
                      size: 90.0,
                    ),
            ),
          ],
        ),
      );
    });
  }
}
