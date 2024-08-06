import '/customizations.dart';

class AppUrls {
  static String countryUrl = '$baseClientEndPoint/country/all';
  static String signInUrl = '$baseClientEndPoint/login';
  static String signUpUrl = '$baseClientEndPoint/register';
  static String emailVerifyUrl = '$baseClientEndPoint/email-verify';
  static String cityUrl = '$baseClientEndPoint/city/all';
  static String stateUrl = '$baseClientEndPoint/state/all';
  static String profileInfoUrl = '$baseClientEndPoint/personal/info';
  static String changePasswordUrl =
      '$baseClientEndPoint/profile/password/update';
  static String sendOtpUrl = '$baseClientEndPoint/resend-otp';
  static String resetPasswordUrl = '$baseClientEndPoint/reset-password';
  static String signOutUrl = '$baseClientEndPoint/logout';
  static String deleteAccountUrl = '$baseClientEndPoint/account/delete';
  static String profileInfoUpdate = '$baseClientEndPoint/personal/info/update';
  static String profileImageUpdate = '$baseClientEndPoint/profile/image/update';
  static String myOrdersListUrl = '$baseClientEndPoint/order/all';
  static String orderDetailsUrl = '$baseClientEndPoint/order/details';
  static String jobListUrl = '$baseClientEndPoint/job/all';
  static String jobDetailsUrl = '$baseClientEndPoint/job/details';
  static String profileDetailsUrl = '$baseClientEndPoint/profile/details';
  static String createTicketUrl = '$baseClientEndPoint/ticket/create';
  static String ticketListUrl = '$baseClientEndPoint/ticket/all';
  static String stListUrl = '$baseClientEndPoint/ticket/single/all-message';
  static String stDepartmentsUrl = '$baseClientEndPoint/department/all';
  static String fetchTicketChatUrl = '$baseClientEndPoint/ticket/details';
  static String sendTicketMessageUrl =
      '$baseClientEndPoint/ticket/message-send';
  static String notificationsListUrl =
      '$baseClientEndPoint/notification/unread';
  static String walletHistoryUrl = '$baseClientEndPoint/wallet/history';
  static String chatListUrl = '$baseClientEndPoint/chat/freelancer-list';
  static String conversationUrl = '$baseClientEndPoint/chat/fetch-record';
  static String messageSendUrl = '$baseClientEndPoint/chat/message-send';
  static String categoryUrl = '$baseClientEndPoint/category/all';
  static String skillUrl = '$baseClientEndPoint/skill/all';
  // static String jobFilter = '$baseEndPoint/job/filter';
  static String chatCredentialUrl = '$baseClientEndPoint/chat/credentials';
  static String currencyLanguageUrl = '$baseClientEndPoint/language/all';
  static String translationUrl =
      '$baseClientEndPoint/language/string-translate';
  static String nCountUrl = '$baseClientEndPoint/notification/unread/count';
  static String mCountUrl = '$baseClientEndPoint/chat/unseen-message/count';
  static String updateNotificationUrl = '$baseClientEndPoint/notification/read';
  static String myOffersUrl = '$baseClientEndPoint/offer/all';
  static String offerDetailsUrl = '$baseClientEndPoint/offer/details';
  static String fcmTokenUrl = '$baseClientEndPoint/update/token';
  static String projectFilterUrl = '$baseClientEndPoint/projects/all/filter';
  static String projectDetailsUrl = '$baseClientEndPoint/project/details';
  static String paymentGatewayUrl = '$baseClientEndPoint/payment/gateway-list';
  static String createJobUrl = '$baseClientEndPoint/job/create';
  static String editJobUrl = '$baseClientEndPoint/job/edit';
  static String placeOrderUrl = '$baseClientEndPoint/order/confirm-order';
  static String updatePaymentUrl = '$baseClientEndPoint/order/payment-update';
  static String acceptOrderUrl = '$baseClientEndPoint/order/approve/milestone';
  static String shortlistToggleUrl =
      '$baseClientEndPoint/job/proposal/add-to-shortlist';
  static String requestRevisionUrl =
      '$baseClientEndPoint/order/request-revision/for/order/or/milestone';
  static String proposalRejectUrl = '$baseClientEndPoint/job/proposal/reject';
  static String jobStatusToggleUrl = '$baseClientEndPoint/job/open/close';
}
