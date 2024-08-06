import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/services/category_dropdown_service.dart';

import '../../helper/extension/context_extension.dart';
import '../../helper/extension/string_extension.dart';
import '../../models/category_model.dart';
import '../../utils/components/custom_preloader.dart';
import '../../utils/components/field_label.dart';
import '../../helper/local_keys.g.dart';
import '../../helper/svg_assets.dart';
import '../../services/location/country_dropdown_service.dart';
import 'empty_spacer_helper.dart';

class SubcategoryDropdown extends StatelessWidget {
  final String? hintText;
  final String? textFieldHint;
  final onChanged;
  final iconColor;
  final textStyle;
  final ValueNotifier<SubCategory?> subCatNotifier;
  final ValueNotifier<Category?> catNotifier;
  SubcategoryDropdown(
      {this.hintText,
      this.onChanged,
      this.textFieldHint,
      this.iconColor,
      this.textStyle,
      required this.subCatNotifier,
      required this.catNotifier,
      super.key});

  final ScrollController controller = ScrollController();
  ValueNotifier subCatString = ValueNotifier(null);
  Timer? scheduleTimeout;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: catNotifier,
        builder: (context, cat, chile) {
          return ValueListenableBuilder(
            valueListenable: subCatNotifier,
            builder: (context, selectedValue, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FieldLabel(label: LocalKeys.subcategory),
                InkWell(
                  onTap: () {
                    if (cat == null) {
                      LocalKeys.selectACategoryFirst.showToast();
                      return;
                    }
                    Provider.of<CategoryDropdownService>(context, listen: false)
                        .resetList();
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
                      isScrollControlled: true,
                      builder: (context) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                            color: context.dProvider.whiteColor,
                          ),
                          constraints: BoxConstraints(
                              maxHeight: context.height / 2 +
                                  (MediaQuery.of(context).viewInsets.bottom /
                                      2)),
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
                                          hintText: textFieldHint ??
                                              LocalKeys.searchSubCat,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12),
                                            child: SvgAssets.search.toSVG,
                                          )),
                                      onChanged: (value) async {
                                        scheduleTimeout?.cancel();
                                        scheduleTimeout = Timer(
                                            const Duration(seconds: 1), () {
                                          subCatString.value = value;
                                        });
                                      }),
                                ),
                                Expanded(
                                  child: ValueListenableBuilder(
                                      valueListenable: subCatString,
                                      builder: (context, searchText, child) {
                                        return ListView.separated(
                                            controller: controller,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.only(
                                                right: 20,
                                                left: 20,
                                                bottom: 20),
                                            itemBuilder: (context, index) {
                                              if (cProvider.categoryLoading ||
                                                  (subCatList.length == index &&
                                                      cProvider.nextPage !=
                                                          null)) {
                                                return const SizedBox(
                                                    height: 50,
                                                    width: double.infinity,
                                                    child: Center(
                                                        child:
                                                            CustomPreloader()));
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
                                                  if (element ==
                                                      selectedValue) {
                                                    return;
                                                  }
                                                  subCatNotifier.value =
                                                      element;
                                                  if (onChanged == null) {
                                                    return;
                                                  }
                                                  onChanged(element);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 8,
                                                      vertical: 14),
                                                  child: Text(
                                                    element.subCategory ?? '',
                                                    style: textStyle,
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context,
                                                    index) =>
                                                const SizedBox(
                                                  height: 8,
                                                  child:
                                                      Center(child: Divider()),
                                                ),
                                            itemCount: cProvider
                                                            .categoryLoading ==
                                                        true ||
                                                    cat.subCategories!.isEmpty
                                                ? 1
                                                : cat.subCategories!.length +
                                                    (cProvider.nextPage !=
                                                                null &&
                                                            !cProvider
                                                                .nexLoadingFailed
                                                        ? 1
                                                        : 0));
                                      }),
                                )
                              ],
                            );
                          }),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border:
                          Border.all(color: context.dProvider.black7, width: 1),
                    ),
                    child: Row(
                      children: [
                        8.toWidth,
                        Expanded(
                          flex: 1,
                          child: Text(
                            cat == null
                                ? LocalKeys.selectACategoryFirst
                                : selectedValue?.subCategory ??
                                    LocalKeys.selectSubcategory,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.titleSmall?.copyWith(
                                color: context.dProvider.black6,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: SvgAssets.arrowDown.toSVGSized(24.0),
                        ),
                      ],
                    ),
                  ),
                ),
                EmptySpaceHelper.emptyHeight(12),
              ],
            ),
          );
        });
  }

  List<SubCategory> get subCatList {
    try {
      if (subCatString.value == null || subCatString.value!.isEmpty) {
        return catNotifier.value?.subCategories ?? [];
      }
      return catNotifier.value?.subCategories
              ?.where((element) => element.subCategory == subCatString.value)
              .toList() ??
          [];
    } catch (e) {
      return [];
    }
  }
}
