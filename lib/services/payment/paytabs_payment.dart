import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:xilancer/customizations.dart';

import '../../utils/components/alerts.dart';
import '../../utils/components/custom_preloader.dart';
import '../../utils/components/navigation_pop_icon.dart';

class PaytabsPayment extends StatelessWidget {
  final onSuccess;
  final onFailed;

  final String serverKey;
  final String profileId;
  final currencyCode;
  final amount;
  final orderId;

  PaytabsPayment(
      {Key? key,
      this.onSuccess,
      this.onFailed,
      required this.serverKey,
      required this.profileId,
      this.currencyCode,
      this.amount,
      this.orderId})
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
            future: waitForIt(
              serverKey,
              profileId,
              orderId,
              amount,
              currencyCode,
            ),
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
                  onProgress: (int progress) {
                    // Update loading bar.
                  },
                  onPageStarted: (String url) {},
                  onPageFinished: (String url) async {},
                  onWebResourceError: (WebResourceError error) {},
                  onNavigationRequest: (request) {
                    if (request.url.contains('https://www.xgenious.com')) {
                      onSuccess();
                      return NavigationDecision.prevent;
                    }
                    // if (request.url.contains('https://www.xgenious.com')) {
                    //   onFailed;
                    //   return NavigationDecision.prevent;
                    // }
                    return NavigationDecision.navigate;
                  },
                ));
              return WebViewWidget(
                controller: _controller,
                // initialUrlRequest: URLRequest(url: Uri.parse(url!)),
                // onLoadStop: (c, value) async {
                //   print('load finish url');
                //   print(value);
                //   _controller.getHtml().then((value) {
                //     print(value);
                //     if (value!.contains('transaction successful')) {
                //       Navigator.of(context).pushAndRemoveUntil(
                //           MaterialPageRoute(
                //               builder: (context) => PaymentStatusView(false)),
                //           (Route<dynamic> route) => false);
                //       return;
                //     }
                //     if (value.contains('Transaction not completed')) {
                //       Navigator.of(context).pushAndRemoveUntil(
                //           MaterialPageRoute(
                //               builder: (context) => PaymentStatusView(true)),
                //           (Route<dynamic> route) => false);
                //       return;
                //     }
                //   });
                // },
              );
            }),
      ),
    );
  }

  waitForIt(
    String serverKey,
    String profileId,
    orderId,
    amount,
    currencyCode,
  ) async {
    var headers = {
      'authorization': serverKey ?? "",
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'POST', Uri.parse('https://secure-global.paytabs.com/payment/request'));
    request.body = json.encode({
      "profile_id": profileId,
      "tran_type": "sale",
      "tran_class": "ecom",
      "cart_id": "$orderId",
      "cart_currency": currencyCode,
      "cart_amount": amount,
      "cart_description": "$appLabel payments",
      "paypage_lang": "en",
      "callback": "https://www.xgenious.com",
      "return": ""
    });
    request.headers.addAll(headers);

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
