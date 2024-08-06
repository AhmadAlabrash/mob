import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';

import '../../../helper/local_keys.g.dart';
import '../../../helper/svg_assets.dart';

class ConversationSkeleton extends StatelessWidget {
  const ConversationSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(20),
              reverse: true,
              itemBuilder: (context, index) {
                final list = [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: index.isEven
                        ? context.dProvider.primary40
                        : context.dProvider.black8,
                  ),
                  12.toWidth,
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        constraints:
                            BoxConstraints(maxWidth: context.width - 86),
                        decoration: BoxDecoration(
                            color: index.isEven
                                ? context.dProvider.black8
                                : context.dProvider.primary40,
                            borderRadius: BorderRadius.only(
                              bottomLeft: const Radius.circular(12),
                              bottomRight: const Radius.circular(12),
                              topRight: index.isEven
                                  ? const Radius.circular(12)
                                  : const Radius.circular(0),
                              topLeft: index.isEven
                                  ? const Radius.circular(0)
                                  : const Radius.circular(12),
                            )),
                        child: const SizedBox(
                          width: double.infinity,
                          height: 14,
                        ),
                      ),
                    ],
                  ),
                ];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: index.isEven ? list : list.reversed.toList(),
                );
              },
              separatorBuilder: (context, index) => 12.toHeight,
              itemCount: 10),
        ).shim,
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: context.dProvider.whiteColor,
              border: Border(top: BorderSide(color: context.dProvider.black7))),
          child: Column(
            children: [
              TextFormField(
                enabled: false,
                decoration: InputDecoration(
                  hintText: '${LocalKeys.message}...',
                ),
              ),
              16.toHeight,
              Row(
                children: [
                  Expanded(
                    flex: 16,
                    child: OutlinedButton(
                      onPressed: null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgAssets.paperclip.toSVGSized(18),
                          6.toWidth,
                          Text(LocalKeys.attachFile),
                        ],
                      ),
                    ),
                  ),
                  const Expanded(flex: 1, child: SizedBox()),
                  Expanded(
                    flex: 16,
                    child: ElevatedButton(
                      onPressed: null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgAssets.send
                              .toSVGSized(18, color: context.dProvider.black6),
                          6.toWidth,
                          Text(LocalKeys.sendMessage),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
