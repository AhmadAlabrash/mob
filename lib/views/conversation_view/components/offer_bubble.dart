import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_button.dart';

class OfferBubble extends StatelessWidget {
  final title;
  final description;
  final totalAmount;
  final deadline;
  final milestones;
  final senderFromWeb;
  const OfferBubble({
    super.key,
    this.title,
    this.description,
    this.totalAmount,
    this.deadline,
    this.milestones,
    this.senderFromWeb,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width - 40,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: const Radius.circular(12),
            bottomRight: const Radius.circular(12),
            topRight: senderFromWeb
                ? const Radius.circular(12)
                : const Radius.circular(0),
            topLeft: senderFromWeb
                ? const Radius.circular(0)
                : const Radius.circular(12),
          ),
          color: context.dProvider.whiteColor,
          border: Border.all(
            color: context.dProvider.black8,
            width: 2,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.titleMedium?.bold6,
          ).hp20,
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 24,
          ),
          Text(
            description,
            style:
                context.titleSmall?.copyWith(color: context.dProvider.black4),
          ).hp20,
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 24,
          ),
          Row(
            children: [
              Expanded(
                  flex: 24,
                  child: RichText(
                    text: TextSpan(
                        text: "${LocalKeys.offerAmount}: ",
                        style: context.titleSmall,
                        children: [
                          TextSpan(
                              text: "380".cur,
                              style: context.titleSmall?.copyWith(
                                  color: context.dProvider.primaryColor))
                        ]),
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Container(
                        height: 36,
                        width: 2,
                        color: context.dProvider.black8,
                      ),
                    ],
                  )),
              Expanded(
                  flex: 24,
                  child: Text(
                      "${LocalKeys.decline}: ${DateFormat("dd-MM-yy").format(deadline)}")),
            ],
          ).hp20,
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 24,
          ),
          Text(
            LocalKeys.milestones,
            style: context.titleMedium?.bold6,
          ).hp20,
          ...Iterable.generate(3)
              .map(
                (e) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: e == 0
                          ? context.dProvider.primary05
                          : context.dProvider.black9,
                      border: Border.all(
                        color: e == 0
                            ? context.dProvider.primaryColor
                            : context.dProvider.black7,
                      )),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 12,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Milestone title"),
                            4.toHeight,
                            Text("380".cur,
                                style: context.titleSmall
                                    ?.copyWith(
                                        color: context.dProvider.primaryColor)
                                    .bold6)
                          ],
                        ),
                      ),
                      const Expanded(
                        flex: 1,
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: e == 0
                                ? context.dProvider.primaryColor
                                : context.dProvider.black8,
                          ),
                          child: Text(
                            e == 0 ? LocalKeys.funded : LocalKeys.notFunded,
                            textAlign: TextAlign.center,
                            style: context.titleSmall?.copyWith(
                                color: e == 0
                                    ? context.dProvider.whiteColor
                                    : null),
                          ),
                        ),
                      ),
                    ],
                  ),
                ).hp20,
              )
              .toList(),
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 24,
          ),
          CustomButton(
                  onPressed: () {},
                  btText: LocalKeys.acceptOffer,
                  isLoading: false)
              .hp20,
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 24,
          ),
          SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () {}, child: Text(LocalKeys.viewJob)))
              .hp20,
          Divider(
            color: context.dProvider.black8,
            thickness: 2,
            height: 24,
          ),
          CustomButton(
            onPressed: () {},
            btText: LocalKeys.decline,
            isLoading: false,
            backgroundColor: context.dProvider.warningColor,
          ).hp20
        ],
      ),
    );
  }
}
