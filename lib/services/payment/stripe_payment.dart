import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/customizations.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class StripePayment {
  Map<String, dynamic>? paymentIntent;

  Future<void> makePayment(BuildContext context, publicKey, secretKey,
      num amount, currencyCode, onSuccess, onFailed) async {
    if (publicKey == null || secretKey == null) {
      LocalKeys.invalidDeveloperKeys.showToast();
      return;
    }
    // Stripe.publishableKey =
    //     "";
    Stripe.publishableKey = publicKey.toString();
    await Stripe.instance.applySettings();
    try {
      paymentIntent = await createPaymentIntent(
          context, (amount * 100).round().toString(), currencyCode, secretKey);
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  // setupIntentClientSecret: secretKey,
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.light,
                  merchantDisplayName: appLabel))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet(context, onSuccess, onFailed);
    } catch (e, s) {
      onFailed();
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(BuildContext context, onSuccess, onFailed) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        onSuccess();

        paymentIntent = null;
      }).onError((error, stackTrace) async {
        print('Error is:--->$error $stackTrace');
        onFailed();
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      await onFailed();
    } catch (e) {
      print('$e');
      await onFailed();
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(
      BuildContext context, String amount, String currency, secretKey) async {
    // try {
    Map<String, dynamic> body = {
      'amount': amount,
      'currency': currency,
      'payment_method_types[]': 'card'
    };

    var response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      headers: {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: body,
    );
    // ignore: avoid_print
    print('Payment Intent Body->>> ${response.body}');
    return jsonDecode(response.body);
    // } catch (err) {
    //   // ignore: avoid_print
    //   print('err charging user: ${err.toString()}');
    // }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
