import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';

import '../../helper/extension/context_extension.dart';
import '../../helper/extension/string_extension.dart';
import '../../models/country_model.dart';
import '../../utils/components/custom_preloader.dart';
import '../../utils/components/field_label.dart';
import '../../helper/local_keys.g.dart';
import '../../helper/svg_assets.dart';
import '../../services/location/country_dropdown_service.dart';
import 'empty_spacer_helper.dart';

class CountryDropdown extends StatelessWidget {
  final String? hintText;
  final String? textFieldHint;
  final onChanged;
  final iconColor;
  final textStyle;
  final ValueNotifier<Country?> countryNotifier;
  CountryDropdown(
      {this.hintText,
      this.onChanged,
      this.textFieldHint,
      this.iconColor,
      this.textStyle,
      required this.countryNotifier,
      super.key});

  final ScrollController controller = ScrollController();
  Timer? scheduleTimeout;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: countryNotifier,
      builder: (context, selectedValue, child) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FieldLabel(label: LocalKeys.country),
          InkWell(
            onTap: () {
              Provider.of<CountryDropdownService>(context, listen: false)
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
                    child: Consumer<CountryDropdownService>(
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
                                        LocalKeys.searchCountry,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: SvgAssets.search.toSVG,
                                    )),
                                onChanged: (value) async {
                                  scheduleTimeout?.cancel();
                                  scheduleTimeout =
                                      Timer(const Duration(seconds: 1), () {
                                    cProvider.setCountrySearchValue(value);
                                    cProvider.getCountries();
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
                                  if (cProvider.countryLoading ||
                                      (cProvider.countryDropdownList.length ==
                                              index &&
                                          cProvider.nextPage != null)) {
                                    return const SizedBox(
                                        height: 50,
                                        width: double.infinity,
                                        child:
                                            Center(child: CustomPreloader()));
                                  }
                                  if (cProvider.countryDropdownList.isEmpty) {
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
                                  if (cProvider.countryDropdownList.length ==
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
                                      cProvider.countryDropdownList[index];
                                  return InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      if (element == selectedValue) {
                                        return;
                                      }
                                      countryNotifier.value = element;
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
                                itemCount: cProvider.countryLoading == true ||
                                        cProvider.countryDropdownList.isEmpty
                                    ? 1
                                    : cProvider.countryDropdownList.length +
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
                  Text(
                    selectedValue?.name ?? LocalKeys.selectCountry,
                    style: context.titleSmall?.copyWith(
                        color: (selectedValue?.name == null
                            ? context.dProvider.black5
                            : context.dProvider.black3),
                        fontWeight: FontWeight.w600),
                  ),
                  const Spacer(),
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
      final cd = Provider.of<CountryDropdownService>(context, listen: false);
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
