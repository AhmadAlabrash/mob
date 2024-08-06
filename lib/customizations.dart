import 'package:flutter/material.dart';

String siteLink = 'https://exgig.com';

String appLabel = 'ExGIG';
String storeLabel = "ExGIG";
String paymentGatewayKey = "ExGIG";
String appVersion = '1.0';
String paymentUpdateEncryptionKey = "apipkey";

const Color primaryColor = Color(0xff1877f2);
const Color blackColor = Color(0xff101828);
const Color whiteColor = Color(0xffffffff);
const Color hintColor = Color(0xff9a9a9e);
const Color borderColor = Color(0xffCDCCCE);
const Color secondaryColor = Color(0xff004225);
const Color warningColor = Color(0xffEB4747);
const Color greenColor = Color(0xff65C18C);
const Color yellowColor = Color(0xffFFB200);

const Color gOneColor = Color(0xff6176F6);
const gTwoColor = Color(0xffFAA500);

List<Color> get chatAvatarBGColors => [
      const Color(0xff0087BF),
      const Color(0xff5A8770),
      const Color(0xff9A89B5),
      const Color(0xffF5888D),
      const Color(0xff98A2B3),
      const Color(0xffF18636),
    ];
List<Color> get statusColors => [
      const Color(0xff9a9a9e),
      const Color(0xff65C18C),
      const Color(0xffEB4747),
    ];

// Don't change anything here
String get baseEndPoint => "$siteLink/api/v1/freelancer";
String get baseClientEndPoint => "$siteLink/api/v1/client";
String get userProfilePath => "$siteLink/assets/uploads/profile";
String get projectAssetPath => "$siteLink/assets/uploads/project";
String get jobProposalAssetPath => "$siteLink/assets/uploads/jobs/proposal";
