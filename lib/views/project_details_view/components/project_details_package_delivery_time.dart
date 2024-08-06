import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/profile_info_service.dart';

import '../../../view_models/project_details_view_model/project_details_view_model.dart';

class ProjectDetailsPackageDeliveryTime extends StatelessWidget {
  const ProjectDetailsPackageDeliveryTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pdm = ProjectDetailsViewModel.instance;
    return Container(
      height: 72,
      decoration: BoxDecoration(
          color: context.dProvider.whiteColor,
          border: Border(
            top: BorderSide(color: context.dProvider.black8, width: 1),
            bottom: BorderSide(color: context.dProvider.black8, width: 1),
          )),
      child: Row(
        children: [
          Container(
            width: context.width / 2.2,
            padding: EdgeInsets.only(
              right: dProvider.textDirectionRight ? 20 : 0,
              left: dProvider.textDirectionRight ? 0 : 20,
            ),
            child:
                Text(LocalKeys.deliveryTime, style: context.titleSmall?.bold6),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: VerticalDivider(
              thickness: 2,
              color: context.dProvider.black8,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: pdm.packageIndex,
            builder: (context, value, child) {
              return Container(
                width: context.width / 2.2,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Consumer<ProfileInfoService>(
                    builder: (context, cpProvider, child) {
                  return Text(pdm.packages[value].deliveryTime.toString());
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
