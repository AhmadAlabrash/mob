import 'dart:convert';

import 'package:xilancer/helper/extension/string_extension.dart';

ProjectDetailsModel projectDetailsModelFromJson(String str) =>
    ProjectDetailsModel.fromJson(json.decode(str));

String projectDetailsModelToJson(ProjectDetailsModel data) =>
    json.encode(data.toJson());

class ProjectDetailsModel {
  ProjectDetails? projectDetails;
  String? projectFilePath;
  String? freelancerTitle;
  String? country;
  String? state;
  num completeOrdersCount;
  num projectRating;
  num freelancerRating;
  num freelancerTotalRating;
  ChatInfo? chatInfo;

  ProjectDetailsModel({
    this.projectDetails,
    this.projectFilePath,
    this.freelancerTitle,
    this.country,
    this.state,
    required this.completeOrdersCount,
    required this.projectRating,
    required this.freelancerRating,
    required this.freelancerTotalRating,
    this.chatInfo,
  });

  factory ProjectDetailsModel.fromJson(json) => ProjectDetailsModel(
        projectDetails: json["project_details"] == null
            ? null
            : ProjectDetails.fromJson(json["project_details"]),
        projectFilePath: json["project_file_path"],
        freelancerTitle: json["freelancer_title"],
        country: json["country"],
        state: json["state"],
        completeOrdersCount:
            json["complete_orders_count"].toString().tryToParse,
        projectRating: json["rating"].toString().tryToParse,
        freelancerRating: json["freelancer_avg_rating"].toString().tryToParse,
        freelancerTotalRating:
            json["freelancer_total_rating"].toString().tryToParse,
        chatInfo: (json["chat_info"] == null) || (json["chat_info"] == "")
            ? null
            : ChatInfo.fromJson(json["chat_info"]),
      );

  Map<String, dynamic> toJson() => {
        "project_details": projectDetails?.toJson(),
        "project_file_path": projectFilePath,
        "freelancer_title": freelancerTitle,
        "country": country,
        "state": state,
        "complete_orders_count": completeOrdersCount,
      };
}

class ProjectDetails {
  dynamic id;
  dynamic userId;
  dynamic categoryId;
  String? title;
  String? slug;
  String? description;
  String? image;
  String? basicTitle;
  dynamic standardTitle;
  dynamic premiumTitle;
  dynamic basicRevision;
  dynamic standardRevision;
  dynamic premiumRevision;
  dynamic basicDelivery;
  dynamic standardDelivery;
  dynamic premiumDelivery;
  num basicRegularCharge;
  num basicDiscountCharge;
  dynamic standardRegularCharge;
  dynamic standardDiscountCharge;
  dynamic premiumRegularCharge;
  dynamic premiumDiscountCharge;
  dynamic projectOnOff;
  dynamic projectApproveRequest;
  dynamic status;
  String? isPro;
  DateTime? proExpireDate;
  dynamic offerPackagesAvailableOrNot;
  DateTime? createdAt;
  DateTime? updatedAt;
  num completeOrdersCount;
  num ratingCount;
  ProjectCreator? projectCreator;
  List<ProjectAttribute>? projectAttributes;
  List<dynamic>? ratings;

  ProjectDetails({
    this.id,
    this.userId,
    this.categoryId,
    this.title,
    this.slug,
    this.description,
    this.image,
    this.basicTitle,
    this.standardTitle,
    this.premiumTitle,
    this.basicRevision,
    this.standardRevision,
    this.premiumRevision,
    this.basicDelivery,
    this.standardDelivery,
    this.premiumDelivery,
    required this.basicRegularCharge,
    required this.basicDiscountCharge,
    this.standardRegularCharge,
    this.standardDiscountCharge,
    this.premiumRegularCharge,
    this.premiumDiscountCharge,
    this.projectOnOff,
    this.projectApproveRequest,
    this.status,
    this.isPro,
    this.proExpireDate,
    this.offerPackagesAvailableOrNot,
    this.createdAt,
    this.updatedAt,
    required this.completeOrdersCount,
    required this.ratingCount,
    this.projectCreator,
    this.projectAttributes,
    this.ratings,
  });

  factory ProjectDetails.fromJson(Map<String, dynamic> json) => ProjectDetails(
        id: json["id"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        title: json["title"],
        slug: json["slug"],
        description: json["description"],
        image: json["image"],
        basicTitle: json["basic_title"],
        standardTitle: json["standard_title"],
        premiumTitle: json["premium_title"],
        basicRevision: json["basic_revision"].toString().tryToParse,
        standardRevision: json["standard_revision"].toString().tryToParse,
        premiumRevision: json["premium_revision"].toString().tryToParse,
        basicDelivery: json["basic_delivery"],
        standardDelivery: json["standard_delivery"],
        premiumDelivery: json["premium_delivery"],
        basicRegularCharge: json["basic_regular_charge"].toString().tryToParse,
        basicDiscountCharge:
            json["basic_discount_charge"].toString().tryToParse,
        standardRegularCharge:
            json["standard_regular_charge"].toString().tryToParse,
        standardDiscountCharge:
            json["standard_discount_charge"].toString().tryToParse,
        premiumRegularCharge:
            json["premium_regular_charge"].toString().tryToParse,
        premiumDiscountCharge:
            json["premium_discount_charge"].toString().tryToParse,
        projectOnOff: json["project_on_off"],
        projectApproveRequest: json["project_approve_request"],
        status: json["status"],
        isPro: json["is_pro"],
        proExpireDate: json["pro_expire_date"] == null
            ? null
            : DateTime.parse(json["pro_expire_date"]),
        offerPackagesAvailableOrNot: json["offer_packages_available_or_not"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        completeOrdersCount: json["complete_orders_count"],
        ratingCount: json["ratings_count"],
        projectCreator: json["project_creator"] == null
            ? null
            : ProjectCreator.fromJson(json["project_creator"]),
        projectAttributes: json["project_attributes"] == null
            ? []
            : List<ProjectAttribute>.from(json["project_attributes"]!
                .map((x) => ProjectAttribute.fromJson(x))),
        // ratings: json["ratings"] == null
        //     ? []
        //     : List<dynamic>.from(json["ratings"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "category_id": categoryId,
        "title": title,
        "slug": slug,
        "description": description,
        "image": image,
        "basic_title": basicTitle,
        "standard_title": standardTitle,
        "premium_title": premiumTitle,
        "basic_revision": basicRevision,
        "standard_revision": standardRevision,
        "premium_revision": premiumRevision,
        "basic_delivery": basicDelivery,
        "standard_delivery": standardDelivery,
        "premium_delivery": premiumDelivery,
        "basic_regular_charge": basicRegularCharge,
        "basic_discount_charge": basicDiscountCharge,
        "standard_regular_charge": standardRegularCharge,
        "standard_discount_charge": standardDiscountCharge,
        "premium_regular_charge": premiumRegularCharge,
        "premium_discount_charge": premiumDiscountCharge,
        "project_on_off": projectOnOff,
        "project_approve_request": projectApproveRequest,
        "status": status,
        "is_pro": isPro,
        "pro_expire_date": proExpireDate?.toIso8601String(),
        "offer_packages_available_or_not": offerPackagesAvailableOrNot,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "complete_orders_count": completeOrdersCount,
        "project_creator": projectCreator?.toJson(),
        "project_attributes": projectAttributes == null
            ? []
            : List<dynamic>.from(projectAttributes!.map((x) => x.toJson())),
        "ratings":
            ratings == null ? [] : List<dynamic>.from(ratings!.map((x) => x)),
      };
}

class ProjectAttribute {
  dynamic id;
  dynamic userId;
  dynamic createProjectId;
  String? type;
  String? checkNumericTitle;
  String? basicCheckNumeric;
  String? standardCheckNumeric;
  String? premiumCheckNumeric;
  dynamic createdAt;
  DateTime? updatedAt;

  ProjectAttribute({
    this.id,
    this.userId,
    this.createProjectId,
    this.type,
    this.checkNumericTitle,
    this.basicCheckNumeric,
    this.standardCheckNumeric,
    this.premiumCheckNumeric,
    this.createdAt,
    this.updatedAt,
  });

  factory ProjectAttribute.fromJson(Map<String, dynamic> json) =>
      ProjectAttribute(
        id: json["id"],
        userId: json["user_id"],
        createProjectId: json["create_project_id"],
        type: json["type"],
        checkNumericTitle: json["check_numeric_title"],
        basicCheckNumeric: json["basic_check_numeric"],
        standardCheckNumeric: json["standard_check_numeric"],
        premiumCheckNumeric: json["premium_check_numeric"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "create_project_id": createProjectId,
        "type": type,
        "check_numeric_title": checkNumericTitle,
        "basic_check_numeric": basicCheckNumeric,
        "standard_check_numeric": standardCheckNumeric,
        "premium_check_numeric": premiumCheckNumeric,
        "created_at": createdAt,
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class ProjectCreator {
  dynamic id;
  String? firstName;
  String? lastName;
  dynamic hourlyRate;
  String? experienceLevel;
  String? email;
  String? phone;
  String? username;
  String? image;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic userType;
  DateTime? checkOnlineStatus;
  dynamic checkWorkAvailability;
  dynamic userActiveInactiveStatus;
  dynamic userVerifiedStatus;
  dynamic isSuspend;
  dynamic termsCondition;
  dynamic about;
  String? isEmailVerified;
  String? google2FaSecret;
  dynamic google2FaEnableDisableDisable;
  dynamic googleId;
  dynamic facebookId;
  dynamic githubId;
  String? emailVerifyToken;
  String? firebaseDeviceToken;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  UserIntroduction? userIntroduction;
  UserCountry? userCountry;
  UserState? userState;

  ProjectCreator({
    this.id,
    this.firstName,
    this.lastName,
    this.hourlyRate,
    this.experienceLevel,
    this.email,
    this.phone,
    this.username,
    this.image,
    this.countryId,
    this.stateId,
    this.cityId,
    this.userType,
    this.checkOnlineStatus,
    this.checkWorkAvailability,
    this.userActiveInactiveStatus,
    this.userVerifiedStatus,
    this.isSuspend,
    this.termsCondition,
    this.about,
    this.isEmailVerified,
    this.google2FaSecret,
    this.google2FaEnableDisableDisable,
    this.googleId,
    this.facebookId,
    this.githubId,
    this.emailVerifyToken,
    this.firebaseDeviceToken,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userIntroduction,
    this.userCountry,
    this.userState,
  });

  factory ProjectCreator.fromJson(Map<String, dynamic> json) => ProjectCreator(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        hourlyRate: json["hourly_rate"],
        experienceLevel: json["experience_level"],
        email: json["email"],
        phone: json["phone"],
        username: json["username"],
        image: json["image"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        cityId: json["city_id"],
        userType: json["user_type"],
        checkOnlineStatus: json["check_online_status"] == null
            ? null
            : DateTime.parse(json["check_online_status"]),
        checkWorkAvailability: json["check_work_availability"],
        userActiveInactiveStatus:
            json["user_active_inactive_status"].toString() == "1",
        userVerifiedStatus: json["user_verified_status"],
        isSuspend: json["is_suspend"],
        about: json["about"],
        isEmailVerified: json["is_email_verified"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        userIntroduction: json["user_introduction"] == null
            ? null
            : UserIntroduction.fromJson(json["user_introduction"]),
        userCountry: json["user_country"] == null
            ? null
            : UserCountry.fromJson(json["user_country"]),
        userState: json["user_state"] == null
            ? null
            : UserState.fromJson(json["user_state"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "hourly_rate": hourlyRate,
        "experience_level": experienceLevel,
        "email": email,
        "phone": phone,
        "username": username,
        "image": image,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "user_type": userType,
        "check_online_status": checkOnlineStatus?.toIso8601String(),
        "check_work_availability": checkWorkAvailability,
        "user_active_inactive_status": userActiveInactiveStatus,
        "user_verified_status": userVerifiedStatus,
        "is_suspend": isSuspend,
        "terms_condition": termsCondition,
        "about": about,
        "is_email_verified": isEmailVerified,
        "google_2fa_secret": google2FaSecret,
        "google_2fa_enable_disable_disable": google2FaEnableDisableDisable,
        "google_id": googleId,
        "facebook_id": facebookId,
        "github_id": githubId,
        "email_verify_token": emailVerifyToken,
        "firebase_device_token": firebaseDeviceToken,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "user_introduction": userIntroduction?.toJson(),
        "user_country": userCountry?.toJson(),
        "user_state": userState?.toJson(),
      };
}

class UserCountry {
  dynamic id;
  String? country;
  dynamic status;

  UserCountry({
    this.id,
    this.country,
    this.status,
  });

  factory UserCountry.fromJson(Map<String, dynamic> json) => UserCountry(
        id: json["id"],
        country: json["country"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country": country,
        "status": status,
      };
}

class UserIntroduction {
  dynamic id;
  dynamic userId;
  String? title;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserIntroduction({
    this.id,
    this.userId,
    this.title,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory UserIntroduction.fromJson(Map<String, dynamic> json) =>
      UserIntroduction(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class UserState {
  dynamic id;
  dynamic countryId;
  String? state;
  dynamic status;
  String? timezone;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserState({
    this.id,
    this.countryId,
    this.state,
    this.status,
    this.timezone,
    this.createdAt,
    this.updatedAt,
  });

  factory UserState.fromJson(Map<String, dynamic> json) => UserState(
        id: json["id"],
        countryId: json["country_id"],
        state: json["state"],
        status: json["status"],
        timezone: json["timezone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "country_id": countryId,
        "state": state,
        "status": status,
        "timezone": timezone,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class ChatInfo {
  dynamic id;
  dynamic freelancerId;
  dynamic clientId;

  ChatInfo({
    this.id,
    this.freelancerId,
    this.clientId,
  });

  static ChatInfo? fromJson(json) => ChatInfo(
        id: json["id"],
        freelancerId: json["freelancer_id"],
        clientId: json["client_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "freelancer_id": freelancerId,
        "client_id": clientId,
      };
}
