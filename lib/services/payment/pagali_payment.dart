import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xilancer/customizations.dart';

import '../../utils/components/alerts.dart';
import '../../utils/components/custom_preloader.dart';
import '../../utils/components/navigation_pop_icon.dart';

class PagaliPayment extends StatelessWidget {
  final onSuccess;
  final onFailed;
  final amount;
  final id;
  PagaliPayment({Key? key, this.onSuccess, this.onFailed, this.amount, this.id})
      : super(key: key);
  String? url;
  final WebViewController _controller = WebViewController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: NavigationPopIcon(onTap: () async {
          Alerts().paymentFailWarning(context, onFailed: onFailed);
        }),
      ),
      body: WillPopScope(
        onWillPop: () async {
          bool canGoBack = await _controller.canGoBack();
          if (canGoBack) {
            _controller.goBack();
            return false;
          }
          Alerts().paymentFailWarning(context, onFailed: onFailed);
          return false;
        },
        child: FutureBuilder(
            future: waitForIt(amount, id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: SizedBox(height: 60, child: CustomPreloader())),
                  ],
                );
              }
              if (snapshot.hasData) {
                // return errorWidget();
              }
              if (snapshot.hasError) {
                print(snapshot.error);
                // return errorWidget();
              }
              _controller
                ..loadRequest(Uri.parse(url ?? ''))
                ..setJavaScriptMode(JavaScriptMode.unrestricted)
                ..setNavigationDelegate(NavigationDelegate(
                  onProgress: (int progress) {},
                  onPageFinished: (url) async {
                    // await response=    http.post(Uri.parse(url)).then((value) {
                    //       print(value);
                    //       if (value!.contains('transaction successful')) {
                    //         onSuccess();
                    //         return;
                    //       }
                    //       if (value.contains('Transaction not completed')) {
                    //         // Provider.of<ConfirmPaymentService>(context, listen: false)
                    //         //     .confirmPayment(context);
                    //         onFailed();
                    //         return;
                    //       }
                    //     });
                  },
                  onNavigationRequest: (request) async {
                    return NavigationDecision.navigate;
                  },
                  onWebResourceError: (WebResourceError error) {},
                ));
              return WebViewWidget(controller: _controller);
            }),
      ),
    );
  }

  waitForIt(String amount, id) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://www.pagali.cv/pagali/index.php?r=pgPaymentInterface/ecommercePayment'));
    request.fields.addAll({
      'item_name': '["$appLabel payment"]',
      'quantity': '["1"]',
      'item_number': '["1"]',
      'amount': '[$amount]',
      'total_item': '["1"]',
      'order_id': '$id',
      'id_ent': "$appLabel payment",
      'currency_code': '"1"',
      'total': '"["$amount"]"',
      'notify': 'payment.failed',
      'id_temp': 'payment.failed',
      'return': 'payment.failed'
    });

    http.StreamedResponse response = await request.send();

    final responseData = jsonDecode(await response.stream.bytesToString());
    print(responseData);
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(responseData['redirect_url']);
      // final billCode = responseData.first['BillCode'];
      url = responseData['redirect_url'];
    } else {
      return true;
    }
  }
}
