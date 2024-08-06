import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/intro_service.dart';
import '../../../utils/components/empty_spacer_helper.dart';
import '/helper/extension/context_extension.dart';

class IntroPages extends StatelessWidget {
  final controller;
  const IntroPages({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final iProvider = Provider.of<IntroService>(context, listen: false);
    return SizedBox(
      height: context.height / 1.4,
      child: PageView(
          controller: controller,
          onPageChanged: (index) {
            iProvider.setIndex(index);
          },
          children: iProvider.introData
              .map(
                (e) => Container(
                  alignment: Alignment.bottomCenter,
                  margin: context.paddingLowHorizontal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      EmptySpaceHelper.emptyHeight(10),
                      Container(
                        height: context.height / 1.9,
                        width: context.height / 1.9,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Image.asset(e['image'] as String),
                      ),
                      EmptySpaceHelper.emptyHeight(10),
                      Padding(
                        padding: context.paddingLowHorizontal,
                        child: Text(
                          e['title'] as String,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                color: context.dProvider.whiteColor,
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      EmptySpaceHelper.emptyHeight(5),
                      Padding(
                        padding: context.paddingLowHorizontal,
                        child: Text(
                          e['description'] as String,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: context.dProvider.whiteColor,
                                  fontSize: 15),
                        ),
                      ),
                      EmptySpaceHelper.emptyHeight(16),
                    ],
                  ),
                ),
              )
              .toList()),
    );
  }
}
