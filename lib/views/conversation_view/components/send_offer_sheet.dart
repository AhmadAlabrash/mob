import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/utils/components/field_label.dart';
import 'package:xilancer/views/conversation_view/components/max_amount_suffx.dart';

import '../../../utils/components/select_date_fl.dart';
import 'send_offer_buttons.dart';

class SendOfferSheet extends StatelessWidget {
  const SendOfferSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: context.dProvider.whiteColor,
      ),
      constraints: BoxConstraints(maxHeight: context.height / 1.5),
      child: Column(
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
          Container(
              padding: const EdgeInsets.all(20),
              color: context.dProvider.primary05,
              child: Text(
                LocalKeys.discusBeforeSendingOffer,
                style: context.titleSmall
                    ?.copyWith(color: context.dProvider.black4),
              )),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FieldLabel(label: LocalKeys.totalProposingAmount),
                  TextFormField(
                    decoration: const InputDecoration(
                        prefixIcon: CurrencyPrefix(),
                        suffixIcon: MaxAmountSuffix()),
                  ),
                  16.toHeight,
                  FieldLabel(label: LocalKeys.youWillGet),
                  Container(
                    height: 46,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.dProvider.black9,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "350".cur,
                          style: context.titleLarge
                              ?.copyWith(color: context.dProvider.primaryColor)
                              .bold6,
                        ),
                        SvgAssets.infoCircle.toSVG,
                      ],
                    ),
                  ),
                  16.toHeight,
                  FieldLabel(label: LocalKeys.milestoneName),
                  TextFormField(),
                  Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            FieldLabel(label: LocalKeys.milestoneAmount),
                            TextFormField(
                              decoration: const InputDecoration(
                                prefixIcon: CurrencyPrefix(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Expanded(flex: 1, child: SizedBox()),
                      Expanded(
                          flex: 5,
                          child: SelectDateFL(
                            title: LocalKeys.deliveryDate,
                            onChanged: (value) {},
                          )),
                    ],
                  ),
                  16.toHeight,
                  FieldLabel(label: LocalKeys.description),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: LocalKeys.writeMilestoneDesc,
                    ),
                  ),
                  16.toHeight,
                  OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.add_rounded),
                      label: Text(LocalKeys.addMilestone)),
                  16.toHeight,
                  12.toHeight,
                  const SendOfferButtons()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencyPrefix extends StatelessWidget {
  const CurrencyPrefix({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border(
                left: context.dProvider.textDirectionRight
                    ? BorderSide(
                        color: context.dProvider.black7,
                      )
                    : BorderSide.none,
                right: context.dProvider.textDirectionRight
                    ? BorderSide.none
                    : BorderSide(
                        color: context.dProvider.black7,
                      )),
          ),
          child: Text(
            context.dProvider.currencySymbol,
            style: context.titleLarge
                ?.copyWith(color: context.dProvider.primaryColor)
                .bold6,
          ),
        ),
      ],
    );
  }
}
