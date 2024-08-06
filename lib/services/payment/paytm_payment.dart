import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

import '../../utils/components/alerts.dart';
import '../../utils/components/navigation_pop_icon.dart';

class PaytmPayment extends StatelessWidget {
  final onSuccess;
  final onFailed;
  PaytmPayment({super.key, this.onSuccess, this.onFailed});
  final WebViewController _controller = WebViewController();
  String? html;
  @override
  Widget build(BuildContext context) {
    _controller
      ..loadHtmlString(html ?? "")
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) async {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (request) {
          // if (request.url.contains('https://www.xgenious.com')) {
          //   onSuccess();
          //   return NavigationDecision.prevent;
          // }
          // if (request.url.contains('https://www.xgenious.com')) {
          //   onFailed;
          //   return NavigationDecision.prevent;
          // }
          return NavigationDecision.navigate;
        },
      ));
    return Scaffold(
      appBar: AppBar(
        leading: NavigationPopIcon(onTap: () async {
          Alerts().paymentFailWarning(context);
        }),
      ),
      body: WillPopScope(
        onWillPop: () async {
          bool canGoBack = await _controller.canGoBack();
          if (canGoBack) {
            _controller.goBack();
            return false;
          }
          Alerts().paymentFailWarning(context);
          return false;
        },
        child: WebViewWidget(
          controller: _controller,
          // navigationDelegate: (navData) {
          //   if (navData.url.contains('success')) {
          //     Navigator.of(context).pushAndRemoveUntil(
          //         MaterialPageRoute(
          //             builder: (context) => PaymentStatusView(false)),
          //         (Route<dynamic> route) => false);
          //     return NavigationDecision.prevent;
          //   }
          //   if (navData.url.contains('failed')) {
          //     Navigator.of(context).pushAndRemoveUntil(
          //         MaterialPageRoute(
          //             builder: (context) => PaymentStatusView(true)),
          //         (Route<dynamic> route) => false);
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      ),
    );
  }
}

Future<bool> verifyPayment(String url) async {
  final uri = Uri.parse(url);
  final response = await http.get(uri);
  print(response.body.contains('successful'));
  return response.body.contains('successful');
}
