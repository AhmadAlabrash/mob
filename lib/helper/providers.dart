import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:xilancer/services/account_delete_service.dart';
import 'package:xilancer/services/auth/change_password_service.dart';
import 'package:xilancer/services/auth/reset_password_service.dart';
import 'package:xilancer/services/auth/sign_in_service.dart';
import 'package:xilancer/services/auth/sign_out_service.dart';
import 'package:xilancer/services/chat_list_service.dart';
import 'package:xilancer/services/job_details_service.dart';
import 'package:xilancer/services/job_list_service.dart.dart';
import 'package:xilancer/services/location/city_dropdown_service.dart';
import 'package:xilancer/services/location/state_dropdown_service.dart';
import 'package:xilancer/services/my_order_list_service.dart';
import 'package:xilancer/services/order_details_service.dart';
import 'package:xilancer/services/payment_gateway_service.dart';
import 'package:xilancer/services/profile_edit_service.dart';
import 'package:xilancer/services/profile_info_service.dart';
import 'package:xilancer/services/support_ticket_create_service.dart';
import 'package:xilancer/services/ticket_list_service.dart';
import 'package:xilancer/services/wallet_history_service.dart';

import '../services/auth/otp_service.dart';
import '../services/bookmark_data_service.dart';
import '../services/category_dropdown_service.dart';
import '../services/chat_credential_service.dart';
import '../services/conversation_service.dart';
import '../services/create_job_service.dart';
import '../services/message_notification_count_service.dart';
import '../services/my_offers_service.dart';
import '../services/notifications_list_service.dart';
import '../services/offer_details_service.dart';
import '../services/place_order_service.dart';
import '../services/profile_details_service.dart';
import '../services/project_details_service.dart';
import '../services/project_list_service.dart.dart';
import '../services/skill_dropdown_service.dart';
import '../services/ticket_chat_service.dart';
import '/services/auth/sign_up_service.dart';
import '/services/location/country_dropdown_service.dart';
import '/services/intro_service.dart';
import '/services/app_string_service.dart';
import '../services/dynamics/dynamics_service.dart';

class Providers {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => DynamicsService()),
    ChangeNotifierProvider(create: (context) => AppStringService()),
    ChangeNotifierProvider(create: (context) => IntroService()),
    ChangeNotifierProvider(create: (context) => CountryDropdownService()),
    ChangeNotifierProvider(create: (context) => StatesDropdownService()),
    ChangeNotifierProvider(create: (context) => CityDropdownService()),
    ChangeNotifierProvider(create: (context) => SignUpService()),
    ChangeNotifierProvider(create: (context) => SignInService()),
    ChangeNotifierProvider(create: (context) => OtpService()),
    ChangeNotifierProvider(create: (context) => ProfileInfoService()),
    ChangeNotifierProvider(create: (context) => ProfileEditService()),
    ChangeNotifierProvider(create: (context) => ChangePasswordService()),
    ChangeNotifierProvider(create: (context) => ResetPasswordService()),
    ChangeNotifierProvider(create: (context) => SignOutService()),
    ChangeNotifierProvider(create: (context) => MyOrderListService()),
    ChangeNotifierProvider(create: (context) => OrderDetailsService()),
    ChangeNotifierProvider(create: (context) => JobListService()),
    ChangeNotifierProvider(create: (context) => JobDetailsService()),
    ChangeNotifierProvider(create: (context) => ProfileDetailsService()),
    ChangeNotifierProvider(create: (context) => ChatCredentialService()),
    ChangeNotifierProvider(create: (context) => TicketListService()),
    ChangeNotifierProvider(create: (context) => SupportTicketCreateService()),
    ChangeNotifierProvider(create: (context) => TicketChatService()),
    ChangeNotifierProvider(create: (context) => NotificationsListService()),
    ChangeNotifierProvider(create: (context) => BookmarkDataService()),
    ChangeNotifierProvider(create: (context) => WalletHistoryService()),
    ChangeNotifierProvider(create: (context) => ChatListService()),
    ChangeNotifierProvider(create: (context) => ConversationService()),
    ChangeNotifierProvider(create: (context) => CategoryDropdownService()),
    ChangeNotifierProvider(
        create: (context) => MessageNotificationCountService()),
    ChangeNotifierProvider(create: (context) => AccountDeleteService()),
    ChangeNotifierProvider(create: (context) => MyOffersService()),
    ChangeNotifierProvider(create: (context) => CreateJobService()),
    ChangeNotifierProvider(create: (context) => SkillDropdownService()),
    ChangeNotifierProvider(create: (context) => ProjectListService()),
    ChangeNotifierProvider(create: (context) => ProjectDetailsService()),
    ChangeNotifierProvider(create: (context) => PaymentGatewayService()),
    ChangeNotifierProvider(create: (context) => OfferDetailsService()),
    ChangeNotifierProvider(create: (context) => PlaceOrderService()),
  ];
}
