import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';

import '../../../view_models/project_details_view_model/project_details_view_model.dart';

class PackageName extends StatelessWidget {
  const PackageName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pdm = ProjectDetailsViewModel.instance;
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: context.dProvider.whiteColor,
          border: Border(
            top: BorderSide(color: context.dProvider.black8, width: 1),
            bottom: BorderSide(color: context.dProvider.black8, width: 1),
          )),
      child: Row(
        children: [
          SizedBox(
            width: context.width / 2.2,
          ),
          VerticalDivider(
            thickness: 2,
            color: context.dProvider.black8,
          ),
          ValueListenableBuilder(
              valueListenable: pdm.packageIndex,
              builder: (context, index, child) {
                return SizedBox(
                  width: context.width / 2.2,
                  child: Text(
                    pdm.packages[index].name,
                    style: context.titleMedium?.bold6,
                  ),
                );
              }),
        ],
      ),
    );
  }
}
