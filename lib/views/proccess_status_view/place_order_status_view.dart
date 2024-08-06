import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/services/place_order_service.dart';
import 'package:xilancer/services/profile_info_service.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';

class PlaceOrderStatusView extends StatelessWidget {
  final title;
  final description;
  final ebText;
  final ebOnTap;
  final obText;
  final obOnTap;
  final int status;
  final onWillPop;
  final bool updateStatus;
  const PlaceOrderStatusView({
    Key? key,
    this.title,
    this.description,
    required this.ebText,
    required this.ebOnTap,
    this.obText,
    this.obOnTap,
    required this.status,
    this.onWillPop,
    this.updateStatus = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final poProvider = Provider.of<PlaceOrderService>(context, listen: false);
    final pi = Provider.of<ProfileInfoService>(context, listen: false);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (onWillPop != null) {
            return onWillPop(context);
          } else {
            context.pop;
            ebOnTap();
            return false;
          }
        },
        child: FutureBuilder(
            future: !updateStatus
                ? null
                : poProvider.updatePayment(
                    poProvider.orderId, pi.profileInfoModel.data?.email ?? ""),
            builder: (context, snapShot) {
              return Stack(
                children: [
                  Padding(
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
                                          .copyWith(
                                              fontWeight: FontWeight.normal),
                                      children: const <TextSpan>[],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        if (obText != null)
                          SizedBox(
                              width: context.width - 40,
                              child: OutlinedButton(
                                  onPressed: () => obOnTap(context),
                                  child: Text(obText))),
                        SizedBox(
                            width: context.width - 40,
                            child: ElevatedButton(
                                onPressed: () => ebOnTap(context),
                                child: Text(ebText))),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                  if (snapShot.connectionState == ConnectionState.waiting)
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: context.dProvider.whiteColor.withOpacity(.4),
                      child: const Center(
                        child: CustomPreloader(),
                      ),
                    )
                ],
              );
            }),
      ),
    );
  }
}
