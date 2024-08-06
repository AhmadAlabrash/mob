import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/models/country_model.dart';

import '../../helper/extension/context_extension.dart';
import '../../helper/extension/string_extension.dart';
import '../../models/state_model.dart';
import '../../services/location/state_dropdown_service.dart';
import '../../utils/components/custom_preloader.dart';
import '../../utils/components/field_label.dart';
import '../../helper/local_keys.g.dart';
import '../../helper/svg_assets.dart';
import '../../services/location/country_dropdown_service.dart';
import 'empty_spacer_helper.dart';

class StateDropdown extends StatelessWidget {
  final String? hintText;
  final String? textFieldHint;
  ValueNotifier<Country?> countryNotifier;
  ValueNotifier<States?> stateNotifier;
  final onChanged;
  final iconColor;
  final textStyle;

  StateDropdown(
      {this.hintText,
      required this.countryNotifier,
      required this.stateNotifier,
      this.onChanged,
      this.textFieldHint,
      this.iconColor,
      this.textStyle,
      super.key});

  final ScrollController controller = ScrollController();

  Timer? scheduleTimeout;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: countryNotifier,
      builder: (context, c, child) => ValueListenableBuilder(
        valueListenable: stateNotifier,
        builder: (context, s, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FieldLabel(label: LocalKeys.state),
            InkWell(
              onTap: () {
                if (c == null) {
                  LocalKeys.selectACountry.showToast();
                  return;
                }
                Provider.of<StatesDropdownService>(context, listen: false)
                    .resetList(c.id);
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
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
                              (MediaQuery.of(context).viewInsets.bottom / 2)),
                      child: Consumer<StatesDropdownService>(
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
                                          LocalKeys.searchState,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: SvgAssets.search.toSVG,
                                      )),
                                  onChanged: (value) {
                                    scheduleTimeout?.cancel();
                                    scheduleTimeout =
                                        Timer(const Duration(seconds: 1), () {
                                      cProvider.setStatesSearchValue(value);
                                      cProvider.getStates();
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
                                    if (cProvider.statesLoading ||
                                        (cProvider.statesList.length == index &&
                                            cProvider.nextPage != null)) {
                                      return const SizedBox(
                                          height: 50,
                                          width: double.infinity,
                                          child:
                                              Center(child: CustomPreloader()));
                                    }
                                    if (cProvider.statesList.isEmpty) {
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
                                    if (cProvider.statesList.length == index) {
                                      return const SizedBox();
                                    }
                                    final element = cProvider.statesList[index];
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                        if (element == s) {
                                          return;
                                        }
                                        stateNotifier.value = element;
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
                                  itemCount: cProvider.statesLoading == true ||
                                          cProvider.statesList.isEmpty
                                      ? 1
                                      : cProvider.statesList.length +
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
                      s?.name ?? LocalKeys.selectState,
                      style: context.titleSmall?.copyWith(
                          color: (s?.name == null
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
      ),
    );
  }
}
