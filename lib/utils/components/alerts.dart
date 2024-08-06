import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/views/onboarding_view/onboarding_view.dart';
import 'package:xilancer/views/proccess_status_view/proccess_status_view.dart';
import '/helper/extension/context_extension.dart';
import '/utils/components/custom_preloader.dart';
import '/utils/components/empty_spacer_helper.dart';

import '../../helper/local_keys.g.dart';

class Alerts {
  confirmationAlert({
    required BuildContext context,
    required String title,
    String? description,
    String? buttonText,
    required Future Function() onConfirm,
    Color? buttonColor,
  }) async {
    ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
    await showDialog(
      context: context,
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: context.width - 80,
              decoration: BoxDecoration(
                  color: context.dProvider.whiteColor,
                  borderRadius: BorderRadius.circular(12)),
              constraints: const BoxConstraints(maxWidth: 480),
              child: Stack(
                children: [
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    children: [
                      Center(
                        child: Text(
                          title,
                          style: context.titleLarge?.bold6,
                        ),
                      ),
                      EmptySpaceHelper.emptyHeight(4),
                      Center(
                        child: Text(
                          description ?? '',
                          style: context.titleMedium,
                        ),
                      ),
                      12.toHeight,
                      Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: OutlinedButton(
                              onPressed: () {
                                context.popFalse;
                              },
                              child: Text(
                                LocalKeys.cancel,
                                style: context.titleSmall
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          16.toWidth,
                          ValueListenableBuilder(
                              valueListenable: loadingNotifier,
                              builder: (context, value, child) {
                                return Expanded(
                                    flex: 8,
                                    child: CustomButton(
                                      onPressed: () {
                                        loadingNotifier.value = true;
                                        onConfirm().then((value) =>
                                            loadingNotifier.value = false);
                                      },
                                      backgroundColor: buttonColor ??
                                          context.dProvider.warningColor,
                                      btText: buttonText ?? "Confirm",
                                      isLoading: value,
                                    ));
                              }),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  normalAlert({
    required BuildContext context,
    required String title,
    String? description,
    String? buttonText,
    required Future Function() onConfirm,
    Color? buttonColor,
  }) async {
    ValueNotifier<bool> loadingNotifier = ValueNotifier(false);
    showDialog(
      context: context,
      builder: (context) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: context.width - 80,
              decoration: BoxDecoration(
                  color: context.dProvider.whiteColor,
                  borderRadius: BorderRadius.circular(12)),
              child: Stack(
                children: [
                  ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(20),
                    children: [
                      SizedBox(
                          height: 52,
                          child: Image.asset("assets/images/success.png")),
                      16.toHeight,
                      Center(
                        child: Text(
                          title,
                          style: context.titleMedium?.bold6,
                        ),
                      ),
                      8.toHeight,
                      Center(
                        child: Text(
                          description ?? '',
                          textAlign: TextAlign.center,
                          style: context.titleSmall,
                        ),
                      ),
                      20.toHeight,
                      Row(
                        children: [
                          ValueListenableBuilder(
                              valueListenable: loadingNotifier,
                              builder: (context, value, child) {
                                return Expanded(
                                  flex: 1,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      loadingNotifier.value = true;
                                      onConfirm().then((value) =>
                                          loadingNotifier.value = false);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: buttonColor ??
                                          context.dProvider.warningColor,
                                    ),
                                    child: value
                                        ? const SizedBox(
                                            height: 40,
                                            child: CustomPreloader(
                                              whiteColor: true,
                                            ),
                                          )
                                        : Text(
                                            buttonText ?? "Confirm",
                                            style: context.titleSmall?.copyWith(
                                                fontWeight: FontWeight.w600,
                                                color: context
                                                    .dProvider.whiteColor),
                                          ),
                                  ),
                                );
                              }),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  paymentFailWarning(BuildContext context, {onFailed}) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(LocalKeys.areYouSure),
            content: Text(LocalKeys.yourPaymentWillTerminate),
            actions: [
              TextButton(
                onPressed: onFailed ??
                    () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => ProcessStatusView(
                                    title: LocalKeys.paymentFailed,
                                    ebText: LocalKeys.backToHome,
                                    ebOnTap: () {
                                      context.toPopPage(const OnboardingView());
                                    },
                                    status: 0,
                                  )),
                          (Route<dynamic> route) => false);
                    },
                child: Text(
                  LocalKeys.yes,
                  style: TextStyle(color: context.dProvider.primaryColor),
                ),
              )
            ],
          );
        });
  }
}
