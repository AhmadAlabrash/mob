import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/services/profile_details_service.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/view_models/profile_details_view_model/profile_details_view_model.dart';

import '../../../helper/local_keys.g.dart';

class ProfileDetailsPrice extends StatelessWidget {
  final ProfileDetailsService pd;
  const ProfileDetailsPrice({
    super.key,
    required this.pd,
  });

  @override
  Widget build(BuildContext context) {
    final pdm = ProfileDetailsViewModel.instance;
    return ValueListenableBuilder(
      valueListenable: pdm.editPrice,
      builder: (context, value, child) {
        pdm.priceController.text = "236";
        return ValueListenableBuilder(
            valueListenable: pdm.viewAsClient,
            builder: (context, vac, child) => Row(
                  children: [
                    Expanded(
                        flex: 10,
                        child: value && !vac
                            ? SizedBox(
                                height: 40,
                                child: TextFormField(
                                  controller: pdm.priceController,
                                  keyboardType: TextInputType.number,
                                ),
                              )
                            : Row(
                                children: [
                                  Text(
                                    (pd.profileDetails.user?.hourlyRate ?? 0)
                                        .toStringAsFixed(0)
                                        .cur,
                                    style: context.titleMedium
                                        ?.copyWith(
                                            color:
                                                context.dProvider.primaryColor)
                                        .bold6,
                                  ),
                                  8.toWidth,
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: context.dProvider.yellowColor,
                                        )),
                                    child: Text(
                                      LocalKeys.hour.toUpperCase(),
                                      style: context.bodySmall
                                          ?.copyWith(
                                              color:
                                                  context.dProvider.yellowColor)
                                          .bold6,
                                    ),
                                  ),
                                ],
                              )),
                    if (!vac && value)
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                    if (!vac && value)
                      Expanded(
                        flex: 6,
                        child: CustomButton(
                            onPressed: () {},
                            btText: LocalKeys.save,
                            height: 40,
                            isLoading: false),
                      ),
                    if (!vac && value)
                      Expanded(
                        flex: 3,
                        child: GestureDetector(
                          onTap: () {
                            pdm.editPrice.value = false;
                          },
                          child: const Icon(Icons.close),
                        ),
                      ),
                    if (!vac && !value)
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            pdm.editPrice.value = !pdm.editPrice.value;
                          },
                          child: SizedBox(
                            child: SvgAssets.edit2.toSVGSized(24,
                                color: context.dProvider.primaryColor),
                          ),
                        ),
                      ),
                  ],
                ));
      },
    );
  }
}
