import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/views/sign_in_view/sign_in_view.dart';
import '/views/onboarding_view/onboarding_view.dart';
import '../../../helper/local_keys.g.dart';
import '/helper/extension/context_extension.dart';
import '/services/intro_service.dart';

import 'dot_indicator.dart';

class IntroBase extends StatelessWidget {
  final controller;
  const IntroBase({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Consumer<IntroService>(builder: (context, iProvider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...iProvider.introData.map(
                  (e) => DotIndicator(
                      iProvider.introData.indexOf(e) == iProvider.currentIndex,
                      dotCount: iProvider.introData.length),
                )
              ],
            ),
            30.toHeight,
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: OutlinedButton(
                    onPressed: () {
                      Provider.of<IntroService>(context, listen: false)
                          .seeIntroValue();
                      context.toUntilPage(const OnboardingView());
                      return;
                    },
                    child: Text(
                      LocalKeys.skip,
                      style: TextStyle(
                        color: context.dProvider.whiteColor,
                      ),
                    ),
                  ),
                ),
                20.toWidth,
                Expanded(
                  flex: 1,
                  child: CustomButton(
                    isLoading: false,
                    foregroundColor: context.dProvider.primaryColor,
                    backgroundColor: context.dProvider.whiteColor,
                    onPressed: () {
                      if (iProvider.currentIndex ==
                          (iProvider.introData.length - 1)) {
                        Provider.of<IntroService>(context, listen: false)
                            .seeIntroValue();
                        context.toUntilPage(const OnboardingView());
                        return;
                      }
                      controller.nextPage(
                          duration: context.lowDuration, curve: Curves.easeIn);
                    },
                    btText: iProvider.currentIndex !=
                            (iProvider.introData.length - 1)
                        ? LocalKeys.next
                        : LocalKeys.done,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
