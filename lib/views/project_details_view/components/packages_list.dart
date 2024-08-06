import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../../../view_models/project_details_view_model/project_details_view_model.dart';

class PackagesList extends StatelessWidget {
  const PackagesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final pdm = ProjectDetailsViewModel.instance;
    return Container(
      width: context.width,
      height: 56,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
          color: context.dProvider.whiteColor,
          border: Border(
            top: BorderSide(color: context.dProvider.black8, width: 1),
            bottom: BorderSide(color: context.dProvider.black8, width: 1),
          )),
      child: ListView.separated(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            return ValueListenableBuilder(
              valueListenable: pdm.packageIndex,
              builder: (context, ind, child) => GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  pdm.packageIndex.value = index;
                },
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ind == index
                        ? context.dProvider.primaryColor
                        : context.dProvider.black9,
                  ),
                  child: Text(
                    pdm.packages[index].name,
                    style: context.titleSmall?.copyWith(
                        color: ind == index
                            ? context.dProvider.whiteColor
                            : context.dProvider.black5),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => 12.toWidth,
          itemCount: pdm.packages.length),
    );
  }
}
