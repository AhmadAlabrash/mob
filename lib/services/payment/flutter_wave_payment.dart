import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class FlutterWavePayment {
  late BuildContext context;
  String currency = dProvider.currencyCode;

  void makePayment(BuildContext context, publicKey, secretKey, double amount,
      userName, userPhone, userMail, onSuccess, onFailed) async {
    this.context = context;
    _handlePaymentInitialization(context, publicKey, secretKey, amount,
        userName, userPhone, userMail, onSuccess, onFailed);
  }

  _handlePaymentInitialization(BuildContext context, publicKey, secretKey,
      double amount, userName, userPhone, userMail, onSuccess, onFailed) async {
    debugPrint(publicKey.toString());
    debugPrint(secretKey.toString());
    if (publicKey == null || secretKey == null) {
      LocalKeys.invalidDeveloperKeys.showToast();
    }

    // final style = FlutterwaveStyle(
    //   appBarText: "Flutterwave payment",
    //   buttonColor: context.dProvider.primaryColor,
    //   buttonTextStyle: TextStyle(
    //     color: context.dProvider.whiteColor,
    //     fontSize: 16,
    //   ),
    //   appBarColor: context.dProvider.whiteColor,
    //   dialogCancelTextStyle: TextStyle(
    //     color: context.dProvider.black5,
    //     fontSize: 17,
    //   ),
    //   dialogContinueTextStyle: TextStyle(
    //     color: context.dProvider.primaryColor,
    //     fontSize: 17,
    //   ),
    //   mainBackgroundColor: context.dProvider.whiteColor,
    //   mainTextStyle: TextStyle(
    //       color: context.dProvider.black3, fontSize: 17, letterSpacing: 2),
    //   dialogBackgroundColor: context.dProvider.whiteColor,
    //   appBarIcon: Icon(Icons.arrow_back, color: context.dProvider.black3),
    //   buttonText: "Pay  ${amount.toStringAsFixed(2).cur}",
    //   appBarTitleTextStyle: TextStyle(
    //     color: context.dProvider.whiteColor,
    //     fontSize: 18,
    //   ),
    // );

    final Customer customer =
        Customer(name: userName, phoneNumber: userPhone, email: userMail);

    // final checkoutInfo = Provider.of<CheckoutService>(context, listen: false);
    const orderId = '2145';
    final Flutterwave flutterwave = Flutterwave(
        context: context,
        // style: style,
        publicKey: publicKey,
        currency: currency,
        txRef: const Uuid().v1(),
        amount: amount.toStringAsFixed(2),
        customer: customer,
        paymentOptions: "card, payattitude",
        customization:
            Customization(title: asProvider.getString('SafeCart Products')),
        redirectUrl: "https://www.google.com",
        isTestMode: false);
    var response = await flutterwave.charge().catchError((_) {
      onFailed();
    });
    if (response.success ?? false) {
      onSuccess();
    } else {
      onFailed();
    }
  }
}
