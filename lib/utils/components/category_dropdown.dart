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

class CategoryDropdown extends StatelessWidget {
  final String? hintText;
  final String? textFieldHint;
  final onChanged;
  final iconColor;
  final textStyle;
  final ValueNotifier<Category?> catNotifier;
  final bool isRequired;
  CategoryDropdown(
      {this.hintText,
      this.onChanged,
      this.textFieldHint,
      this.iconColor,
      this.textStyle,
      required this.catNotifier,
      this.isRequired = false,
      super.key});

  final ScrollController controller = ScrollController();
  Timer? scheduleTimeout;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: catNotifier,
      builder: (context, selectedValue, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FieldLabel(
            label: LocalKeys.category,
            isRequired: isRequired,
          ),
          InkWell(
            onTap: () {
              Provider.of<CategoryDropdownService>(context, listen: false)
                  .resetList();
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) {
                  controller.addListener(() {
                    tryLoadingMore(context);
                  });
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
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
                                    hintText: textFieldHint ??
                                        LocalKeys.searchCategory,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: SvgAssets.search.toSVG,
                                    )),
                                onChanged: (value) async {
                                  scheduleTimeout?.cancel();
                                  scheduleTimeout =
                                      Timer(const Duration(seconds: 1), () {
                                    cProvider.setCategorySearchValue(value);
                                    cProvider.getCategory();
                                  });
                                }),
                          ),
                          Expanded(
                            child: ListView.separated(
                                controller: controller,
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(
                                    right: 20, left: 20, bottom: 20),
                                itemBuilder: (context, index) {
                                  if (cProvider.categoryLoading ||
                                      (cProvider.categoryDropdownList.length ==
                                              index &&
                                          cProvider.nextPage != null)) {
                                    return const SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child:
                                            Center(child: CustomPreloader()));
                                  }
                                  if (cProvider.categoryDropdownList.isEmpty) {
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
                                  if (cProvider.categoryDropdownList.length ==
                                      index) {
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
                                  final element =
                                      cProvider.categoryDropdownList[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      if (element == selectedValue) {
                                        return;
                                      }
                                      catNotifier.value = element;
                                      if (onChanged == null) {
                                        return;
                                      }
                                      onChanged(element);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 14),
                                      child: Text(
                                        element?.name ?? '',
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
                                        cProvider.categoryDropdownList.isEmpty
                                    ? 1
                                    : cProvider.categoryDropdownList.length +
                                        (cProvider.nextPage != null &&
                                                !cProvider.nexLoadingFailed
                                            ? 1
                                            : 0)),
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
                border: Border.all(color: context.dProvider.black7, width: 1),
              ),
              child: Row(
                children: [
                  8.toWidth,
                  Expanded(
                    flex: 1,
                    child: Text(
                      selectedValue?.name ?? LocalKeys.selectCategory,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleSmall?.copyWith(
                          color: (selectedValue?.name == null
                              ? context.dProvider.black5
                              : context.dProvider.black3)),
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
  }

  tryLoadingMore(BuildContext context) async {
    try {
      final cd = Provider.of<CategoryDropdownService>(context, listen: false);
      final nextPage = cd.nextPage;
      final nextPageLoading = cd.nextPageLoading;

      if (controller.offset == controller.position.maxScrollExtent &&
          !controller.position.outOfRange) {
        if (nextPage != null && !nextPageLoading) {
          cd.fetchNextPage();
          return;
        }
      }
    } catch (e) {}
  }
}
