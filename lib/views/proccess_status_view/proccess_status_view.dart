import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:xilancer/helper/extension/context_extension.dart';

class ProcessStatusView extends StatelessWidget {
  static const routeName = 'process_status_view';
  final title;
  final description;
  final ebText;
  final ebOnTap;
  final obText;
  final obOnTap;
  final int status;
  final onWillPop;
  const ProcessStatusView(
      {Key? key,
      this.title,
      this.description,
      required this.ebText,
      required this.ebOnTap,
      this.obText,
      this.obOnTap,
      required this.status,
      this.onWillPop})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (onWillPop != null) {
            return onWillPop();
          } else {
            ebOnTap();
            return false;
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Lottie.asset(
                          status == 0
                              ? 'assets/animations/payment_failed.json'
                              : 'assets/animations/payment_success.json',
                          repeat: false,
                        ),
                      ),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (description != null)
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: description,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(fontWeight: FontWeight.normal),
                            children: const <TextSpan>[],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (obText != null)
                OutlinedButton(onPressed: obOnTap, child: Text(obText)),
              SizedBox(
                  width: context.width - 40,
                  child:
                      ElevatedButton(onPressed: ebOnTap, child: Text(ebText))),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
