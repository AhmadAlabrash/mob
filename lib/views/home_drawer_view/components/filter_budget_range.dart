import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../../../view_models/home_drawer_view_model/home_drawer_view_model.dart';

class FilterBudgetRange extends StatelessWidget {
  const FilterBudgetRange({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final hdm = HomeDrawerViewModel.instance;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: context.dProvider.whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocalKeys.budget.capitalizeWords,
            style: context.titleMedium?.bold6,
          ),
          16.toHeight,
          ValueListenableBuilder(
            valueListenable: hdm.rangeValue,
            builder: (context, value, child) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: hdm.minPriceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: LocalKeys.min,
                          ),
                        )),
                    Container(
                      width: 16,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Divider(
                        thickness: 2,
                        color: context.dProvider.black7,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: TextFormField(
                          controller: hdm.maxPriceController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: LocalKeys.max,
                          ),
                        )),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
