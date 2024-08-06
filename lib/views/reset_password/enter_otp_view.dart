import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/view_models/sign_up_view/sign_up_view_model.dart';
import '../../utils/components/navigation_pop_icon.dart';
import '/helper/extension/context_extension.dart';
import '/helper/local_keys.g.dart';
import '/utils/components/field_label.dart';

import '../../services/auth/otp_service.dart';
import '../../utils/components/custom_preloader.dart';
import '../../utils/components/empty_spacer_helper.dart';
import 'new_password_view.dart';

class EnterOtpView extends StatelessWidget {
  static const routeName = 'enter_otp_view';
  String otp;
  bool fromRegister;
  var token;
  var email;
  EnterOtpView(this.otp,
      {this.fromRegister = false, this.token, this.email, super.key});
  TextEditingController? controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        SignUpViewModel.instance.loading.value = false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: NavigationPopIcon(
            onTap: () {
              SignUpViewModel.instance.loading.value = false;
              context.popFalse;
            },
          ),
          title: Text(LocalKeys.verificationCode.capitalizeWords),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: context.dProvider.whiteColor,
                borderRadius: BorderRadius.circular(8)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LottieBuilder.asset(
                  "assets/animations/otp_animation.json",
                  repeat: false,
                ),
                Form(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      FieldLabel(label: LocalKeys.enterYourVerificationCode),
                      Text(
                        LocalKeys.doNotShareCode,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: context.dProvider.black6),
                      ),
                      EmptySpaceHelper.emptyHeight(20),
                      Center(child: otpPinput(context)),
                      EmptySpaceHelper.emptyHeight(30),
                      SizedBox(
                        height: 40,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                softWrap: true,
                                text: TextSpan(
                                  text: LocalKeys.didNotReceived,
                                  style: TextStyle(
                                    color: context.dProvider.black5,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              EmptySpaceHelper.emptyWidth(5),
                              Consumer<OtpService>(
                                builder: (context, otpProvider, child) {
                                  return Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      child!,
                                      if (otpProvider.loadingSendOTP)
                                        Container(
                                          color: context.dProvider.whiteColor,
                                          height: 40,
                                          width: 80,
                                          child: const FittedBox(
                                              child: CustomPreloader()),
                                        ),
                                      if (otpProvider.sendAgainOptionTimer !=
                                              null &&
                                          !otpProvider.loadingSendOTP)
                                        Container(
                                          color: context.dProvider.whiteColor,
                                          height: 40,
                                          child: Row(
                                            children: [
                                              Text(LocalKeys.sendAgainIn,
                                                  style: context
                                                      .titleSmall!.bold6
                                                      .copyWith(
                                                          color: context
                                                              .dProvider
                                                              .primaryColor)),
                                              FittedBox(
                                                child: SlideCountdownSeparated(
                                                  showZeroValue: true,
                                                  shouldShowMinutes: (p0) =>
                                                      true,
                                                  shouldShowDays: (p0) => false,
                                                  shouldShowHours: (p0) =>
                                                      false,
                                                  padding: EdgeInsets.zero,
                                                  separatorPadding:
                                                      EdgeInsets.zero,
                                                  textStyle: context
                                                      .titleSmall!.bold6
                                                      .copyWith(
                                                          color: context
                                                              .dProvider
                                                              .warningColor
                                                              .withOpacity(.7)),
                                                  separator: ':',
                                                  separatorStyle: context
                                                      .titleSmall!.bold6
                                                      .copyWith(
                                                          color: context
                                                              .dProvider
                                                              .warningColor
                                                              .withOpacity(.7)),
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  duration: const Duration(
                                                      seconds: 30),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                    ],
                                  );
                                },
                                child: RichText(
                                  text: TextSpan(
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          controller!.clear();
                                          if (token == null) {
                                            Provider.of<OtpService>(context,
                                                    listen: false)
                                                .sendOTPWithoutToken(
                                                    context, email);
                                          } else {
                                            Provider.of<OtpService>(context,
                                                    listen: false)
                                                .sendOTP(context, email, token);
                                          }
                                        },
                                      text: LocalKeys.sendAgain,
                                      style: TextStyle(
                                          color: context.dProvider.primaryColor,
                                          fontWeight: FontWeight.bold)),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ])),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Pinput otpPinput(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 70,
      height: 56,
      textStyle: TextStyle(
        fontSize: 17,
        color: context.dProvider.black4,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: context.dProvider.black8),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.dProvider.primaryColor),
      borderRadius: BorderRadius.circular(8),
    );
    return Pinput(
      controller: controller,
      separator: EmptySpaceHelper.emptyWidth(8),
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      keyboardType: TextInputType.visiblePassword,
      length: otp.length,
      validator: (s) {
        print(s);
        print(otp);
        print(Provider.of<OtpService>(context, listen: false).otpCode);
        if (s != otp &&
            s != Provider.of<OtpService>(context, listen: false).otpCode) {
          controller!.clear();
          context.snackBar(LocalKeys.wrongOTPCode,
              backgroundColor: context.dProvider.warningColor,
              buttonText: LocalKeys.resendCode, onTap: () {
            controller!.clear();
            if (token == null) {
              Provider.of<OtpService>(context, listen: false)
                  .sendOTPWithoutToken(context, email);
            } else {
              Provider.of<OtpService>(context, listen: false)
                  .sendOTP(context, email, token);
            }
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          });
          return;
        }
        if (fromRegister) {
          Navigator.pop(context, s);
          return;
        }
        Navigator.pop(context, s);

        context.toPopPage(NewPasswordView(
          otp: s,
        ));

        return;
      },
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      showCursor: true,
      onCompleted: (pin) => print(pin),
    );
  }
}
