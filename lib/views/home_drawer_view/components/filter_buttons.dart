import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';

import '../../../helper/local_keys.g.dart';
import '../../../utils/components/custom_button.dart';
import '../../../view_models/home_drawer_view_model/home_drawer_view_model.dart';

class FilterButtons extends StatelessWidget {
  const FilterButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final hdm = HomeDrawerViewModel.instance;
    return Container(
      padding: const EdgeInsets.all(20),
      color: context.dProvider.whiteColor,
      child: Row(
        children: [
          Expanded(
              flex: 8,
              child: OutlinedButton(
                  onPressed: () {
                    hdm.resetFilters(context);

                    context.popFalse;
                  },
                  child: Text(
                    LocalKeys.resetFilter,
                  ))),
          const Expanded(flex: 1, child: SizedBox()),
          Expanded(
              flex: 8,
              child: CustomButton(
                onPressed: () {
                  hdm.setFilters(context);
                  context.popFalse;
                },
                btText: LocalKeys.applyFilter,
                isLoading: false,
                height: null,
              )),
        ],
      ),
    );
  }
}
