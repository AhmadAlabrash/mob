import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/payment/pagali_payment.dart';
import 'package:xilancer/services/payment/sites_way_payment.dart';
import 'package:xilancer/services/place_order_service.dart';
import 'package:xilancer/services/profile_info_service.dart';
import 'package:xilancer/view_models/place_order_view_model/place_order_view_model.dart';

import '../../models/payment_gateway_model.dart';
import '../../services/payment/authorize_net_payment.dart';
import '../../services/payment/billplz_payment.dart';
import '../../services/payment/cash_free_payment.dart';
import '../../services/payment/cinetpay_payment.dart';
import '../../services/payment/flutter_wave_payment.dart';
import '../../services/payment/instamojo_payment.dart';
import '../../services/payment/mercado_pago_payment.dart';
import '../../services/payment/mid_trans_payment.dart';
import '../../services/payment/payfast_payment.dart';
import '../../services/payment/paypal_payment.dart';
import '../../services/payment/paystack_payment.dart';
import '../../services/payment/paytabs_payment.dart';
import '../../services/payment/paytm_payment.dart';
import '../../services/payment/razorpay_payment.dart';
import '../../services/payment/squareup_payment.dart';
import '../../services/payment/stripe_payment.dart';
import '../../services/payment/toyyibpay_payment.dart';
import '../../services/payment/zitopay_payment.dart';
import '../../services/payment/mollie_payment.dart';

Future startPayment(BuildContext context,
    {zUsername,
    authNetCard,
    authNetED,
    authcCode,
    onSuccess,
    onFailed,
    userEmail,
    userPhone,
    userName,
    userCity,
    amount,
    orderId,
    userAddress,
    required Gateway selectedGateway}) async {
  // cProvider.clearSelectedImage();
  print(selectedGateway.name);
  if (selectedGateway.name.toLowerCase().contains('marcadopago')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => MercadopagoPayment(
          amount: amount.toInt(),
          clientSecret: selectedGateway.clientSecret,
          testing: selectedGateway.testMode,
          onFailed: onFailed,
          onSuccess: onSuccess,
          userMail: userEmail,
        ),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('paytm')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaytmPayment(),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('paypal')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaypalPayment(
          clientId: selectedGateway.testMode
              ? selectedGateway.sandboxClientId ?? ""
              : selectedGateway.liveClientId ?? "",
          clientSecret: selectedGateway.testMode
              ? selectedGateway.sandboxClientSecret ?? ""
              : selectedGateway.liveClientSecret ?? "",
          currencyCode: dProvider.currencyCode,
          onFailed: onFailed,
          onSuccess: onSuccess,
        ),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('stripe')) {
    print('here');
    await StripePayment().makePayment(
        context,
        selectedGateway.publicKey,
        selectedGateway.secretKey,
        amount,
        dProvider.currencyCode,
        onSuccess,
        onFailed);
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('razorpay')) {
    context.toPage(
      RazorpayPayment(
          amount: amount,
          apiKey: selectedGateway.apiKey,
          apiSecret: selectedGateway.apiSecret,
          userEmail: userEmail,
          userName: userName,
          userPhone: userPhone,
          orderId: orderId,
          onSuccess: onSuccess,
          onFailed: onFailed),
    );

    return;
  }
  if (selectedGateway.name.toLowerCase().contains('paystack')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaystackPayment(
          amount: amount,
          secretKey: selectedGateway.secretKey,
          userEmail: userEmail,
          onSuccess: onSuccess,
          onFailed: onFailed,
        ),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('flutterwave')) {
    debugPrint("doing flutterwave".toString());
    FlutterWavePayment().makePayment(
        context,
        selectedGateway.publicKey,
        selectedGateway.secretKey,
        amount.toDouble(),
        userName,
        userPhone,
        userEmail,
        onSuccess,
        onFailed);
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('cashfree')) {
    await CashFreePayment()
        .doPayment(
            context,
            selectedGateway.appId,
            selectedGateway.secrectKey,
            amount,
            orderId,
            userName,
            userPhone,
            userEmail,
            onSuccess,
            onFailed)
        .onError((error, stackTrace) => null);
    return;
  }

  // }
  if (selectedGateway.name.toLowerCase().contains('payfast')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PayfastPayment(
          amount: amount.toStringAsFixed(2),
          merchantId: selectedGateway.merchantId,
          merchantKey: selectedGateway.merchantKey,
          testing: selectedGateway.testMode,
          onSuccess: onSuccess,
          onFailed: onFailed,
        ),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('iyzipay')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PayfastPayment(
          amount: amount.toStringAsFixed(2),
          merchantId: selectedGateway.merchantId,
          merchantKey: selectedGateway.merchantKey,
          testing: selectedGateway.testMode,
          onSuccess: onSuccess,
          onFailed: onFailed,
        ),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('sitesway')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => SitesWayPayment(
          amount: amount.toStringAsFixed(2),
          brandId: selectedGateway.brandId,
          apiKey: selectedGateway.apiKey,
          testing: selectedGateway.testMode,
          onSuccess: onSuccess,
          onFailed: onFailed,
          userEmail: userEmail,
          userName: userName,
          currencyCode: dProvider.currencyCode,
          orderId: orderId,
        ),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('zitopay')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ZitopayPayment(
          userName,
          amount: amount.toDouble(),
          username: zUsername,
          onFailed: onFailed,
          onSuccess: onSuccess,
        ),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('paytabs')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PaytabsPayment(
          serverKey: selectedGateway.serverKey ?? "",
          profileId: selectedGateway.profileId ?? "",
          currencyCode: dProvider.currencyCode,
          amount: amount,
          orderId: orderId,
          onSuccess: onSuccess,
          onFailed: onFailed,
        ),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('pagali')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PagaliPayment(
            amount: amount, onSuccess: onSuccess, onFailed: onFailed),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('squareup')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => SquareUpPayment(
          amount: amount.toInt(),
          testing: selectedGateway.testMode,
          accessToken: selectedGateway.accessToken,
          locationId: selectedGateway.locationId,
          currencyCode: dProvider.currencyCode,
          orderId: orderId,
          userEmail: userEmail,
          onSuccess: onSuccess,
          onFailed: onFailed,
        ),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('cinetpay')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => CinetPayPayment(
          testing: selectedGateway.testMode,
          apiKey: selectedGateway.appKey ?? "",
          siteId: selectedGateway.siteId,
          id: orderId.toString(),
          amount: amount,
          currencyCode: dProvider.currencyCode,
          userMail: userEmail,
          userCity: userCity,
          userAddress: userAddress,
          onSuccess: onSuccess,
          onFailed: onFailed,
        ),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('billplz')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => BillplzPayment(
          amount: amount,
          collectionId: selectedGateway.collectionName,
          paymentKey: selectedGateway.key,
          testing: selectedGateway.testMode,
          userMail: userEmail,
          userName: userName,
          onSuccess: onSuccess,
          onFailed: onFailed,
        ),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('toyyibpay')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => ToyyibPayPayment(
          clientSecret: selectedGateway.secretKey ?? "",
          categoryCode: selectedGateway.categoryCode ?? "",
          amount: amount.toStringAsFixed(0),
          onSuccess: onSuccess,
          onFailed: onFailed,
          userEmail: userEmail,
          userName: userName,
          userPhone: userPhone,
        ),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('authorize_dot_net')) {
    debugPrint("_________".toString());
    await AuthrizeNetPay.authorizeNetPay(
      context,
      authNetCard,
      authNetED,
      amount.toStringAsFixed(0),
      authcCode,
      inTesting: selectedGateway.testMode,
      onTransactionApproved: onSuccess,
      onTransactionFailed: onFailed,
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('midtrans')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => MidtransPayment(
            amount: amount.toStringAsFixed(0),
            clientKey: selectedGateway.clientKey,
            serverKey: selectedGateway.serverKey,
            testing: selectedGateway.testMode,
            id: orderId,
            userEmail: userEmail,
            userName: userName,
            userPhone: userPhone,
            onSuccess: onSuccess,
            onFailed: onFailed),
      ),
    );

    return;
  }
  if (selectedGateway.name.toLowerCase().contains('instamojo')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => InstamojoPayment(
            amount: amount.toInt(),
            apiKey: selectedGateway.liveClientId,
            clientId: selectedGateway.liveClientId,
            clientSecret: selectedGateway.clientSecret,
            testing: selectedGateway.testMode,
            userEmail: userEmail,
            userName: userName,
            userPhone: userPhone,
            onSuccess: onSuccess,
            onFailed: onFailed),
      ),
    );
    return;
  }
  if (selectedGateway.name.toLowerCase().contains('mollie')) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => MolliePayment(
          amount: amount.toStringAsFixed(2),
          currency: dProvider.currencyCode,
          publicKey: selectedGateway.publicKey,
          onSuccess: onSuccess,
          onFailed: onFailed,
        ),
      ),
    );
    return;
  }
}
