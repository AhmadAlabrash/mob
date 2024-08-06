import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/services/category_dropdown_service.dart';

import '../../helper/local_keys.g.dart';
import '../../helper/svg_assets.dart';
import '../../models/category_model.dart';
import '../../services/location/country_dropdown_service.dart';
import 'custom_preloader.dart';

class SubCategorySheet extends StatelessWidget {
  final textFieldHint;
  final onChanged;
  final textStyle;
  final ValueNotifier<Category?> category;

  SubCategorySheet(
      {super.key,
      this.textFieldHint,
      this.onChanged,
      this.textStyle,
      required this.category});

  ValueNotifier<String> subCatString = ValueNotifier('');
  Timer? scheduleTimeout;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: category,
        builder: (context, cat, child) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: context.dProvider.whiteColor,
            ),
            constraints: BoxConstraints(
                maxHeight: context.height / 2 +
                    (MediaQuery.of(context).viewInsets.bottom / 2)),
            child: Consumer<CategoryDropdownService>(
                builder: (context, cProvider, child) {
              return Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      height: 4,
                      width: 48,
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: context.dProvider.black7,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: TextFormField(
                        decoration: InputDecoration(
                            hintText: textFieldHint ?? LocalKeys.searchSubCat,
                            prefixIcon: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: SvgAssets.search.toSVG,
                            )),
                        onChanged: (value) async {
                          scheduleTimeout?.cancel();
                          scheduleTimeout =
                              Timer(const Duration(seconds: 1), () {
                            subCatString.value = value;
                          });
                        }),
                  ),
                  ValueListenableBuilder(
                      valueListenable: subCatString,
                      builder: (context, searchText, child) {
                        return Expanded(
                          child: ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.only(
                                  right: 20, left: 20, bottom: 20),
                              itemBuilder: (context, index) {
                                if (cProvider.categoryLoading ||
                                    (subCatList.length == index &&
                                        cProvider.nextPage != null)) {
                                  return const SizedBox(
                                      height: 50,
                                      width: double.infinity,
                                      child: Center(child: CustomPreloader()));
                                }
                                if (subCatList.isEmpty) {
                                  return SizedBox(
                                    width: context.width - 60,
                                    height: 64,
                                    child: Center(
                                      child: Text(
                                        LocalKeys.noResultFound,
                                        style: textStyle,
                                      ),
                                    ),
                                  );
                                }
                                if (subCatList.length == index) {
                                  return SizedBox(
                                    width: context.width - 60,
                                    height: 64,
                                    child: Center(
                                      child: Text(
                                        LocalKeys.noResultFound,
                                        style: textStyle,
                                      ),
                                    ),
                                  );
                                }
                                final element = subCatList[index];

                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    onChanged(element);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 14),
                                    child: Text(
                                      element.subCategory ?? "--",
                                      style: textStyle,
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                    height: 8,
                                    child: Center(child: Divider()),
                                  ),
                              itemCount: cProvider.categoryLoading == true ||
                                      cat!.subCategories!.isEmpty
                                  ? 1
                                  : cat.subCategories!.length +
                                      (cProvider.nextPage != null &&
                                              !cProvider.nexLoadingFailed
                                          ? 1
                                          : 0)),
                        );
                      })
                ],
              );
            }),
          );
        });
  }

  List<SubCategory> get subCatList {
    try {
      if (subCatString.value.isEmpty) {
        return category.value?.subCategories ?? [];
      }
      return category.value?.subCategories
              ?.where((element) => element.subCategory == subCatString.value)
              .toList() ??
          [];
    } catch (e) {
      return [];
    }
  }
}
