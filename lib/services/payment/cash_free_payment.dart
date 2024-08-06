import 'dart:convert';

// import 'package:cashfree_pg/cashfree_pg.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class CashFreePayment {
  late BuildContext context;

  Future doPayment(BuildContext context, appId, secretKey, amount, id, userName,
      userPhone, userMail, onSuccess, onFailed,
      {testing = false}) async {
    this.context = context;
    // final checkoutData =
    //     Provider.of<CheckoutService>(context, listen: false).checkoutModel;

    if (appId == null || secretKey == null) {
      LocalKeys.invalidDeveloperKeys.showToast();
      return;
    }

    final url = Uri.parse(testing
        ? "https://cashfree.com/api/v2/cftoken/order"
        : "https://test.cashfree.com/api/v2/cftoken/order");

    final response = await http.post(url,
        headers: {
          // "x-client-id": "223117f0ebd2772a15e84c769e711322",
          // "x-client-secret": "TESTd1389be7307c3b4afcd2a933cb69a0f3ec57ac30",
          "x-client-id": appId as String,
          "x-client-secret": secretKey as String,
        },
        body: jsonEncode({
          "orderId": id,
          "orderAmount": amount.toStringAsFixed(2),
          "orderCurrency": "INR",
        }));
    print(jsonDecode(response.body)['cftoken']);
    if (200 == 200) {
      Map<String, dynamic> inputParams = {
        "orderId": id,
        "orderAmount": amount.toStringAsFixed(2),
        "customerName": userName,
        "orderCurrency": "INR",
        "appId": appId,
        "customerPhone": userPhone,
        "customerEmail": userMail,
        "stage": testing ? "TEST" : "",
        "tokenData": jsonDecode(response.body)['cftoken'],
      };
      // print(inputParams);
      // final result = await CashfreePGSDK.doPayment(inputParams).then((value) {
      //   print('cashfree payment result $value');
      //   if (value != null) {
      //     if (value['txStatus'] == "SUCCESS") {
      //       debugPrint('Cashfree Payment successfull. Do something here');
      //       onSuccess();
      //     }
      //     if (value['txStatus'] == "CANCELLED") {
      //       debugPrint('Cashfree Payment successfull. Do something here');
      //       onFailed();
      //     }
      //     if (value['txStatus'] == "FAILED") {
      //       debugPrint('Cashfree Payment successfull. Do something here');
      //       onFailed();
      //     }
      //   }
      // });
      // print(result!['txMsg']);
    }
  }
}
