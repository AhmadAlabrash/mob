// To parse this JSON data, do
//
//     final projectListModel = projectListModelFromJson(jsonString);

import 'dart:convert';

import 'package:xilancer/helper/extension/string_extension.dart';

ProjectListModel projectListModelFromJson(String str) =>
    ProjectListModel.fromJson(json.decode(str));

String projectListModelToJson(ProjectListModel data) =>
    json.encode(data.toJson());

class ProjectListModel {
  Projects? projects;
  String? projectFilePath;

  ProjectListModel({
    this.projects,
    this.projectFilePath,
  });

  factory ProjectListModel.fromJson(json) => ProjectListModel(
        projects: json["projects"] == null
            ? null
            : Projects.fromJson(json["projects"]),
        projectFilePath: json["project_file_path"],
      );

  Map<String, dynamic> toJson() => {
        "projects": projects?.toJson(),
        "project_file_path": projectFilePath,
      };
}

class Projects {
  List<Project>? projects;
  dynamic nextPageUrl;

  Projects({
    this.projects,
    this.nextPageUrl,
  });

  factory Projects.fromJson(Map<String, dynamic> json) => Projects(
        projects: json["data"] == null
            ? []
            : List<Project>.from(json["data"]!.map((x) => Project.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {};
}

class Project {
  dynamic id;
  String? title;
  String? slug;
  dynamic userId;
  num basicRegularCharge;
  num? basicDiscountCharge;
  num ratingCount;
  num? avgRating;
  String? basicDelivery;
  String? description;
  String? image;
  List<Rating>? ratings;
  ProjectCreator? projectCreator;
  dynamic completeOrdersCount;

  Project({
    this.id,
    this.title,
    this.slug,
    this.userId,
    required this.basicRegularCharge,
    this.basicDiscountCharge,
    this.basicDelivery,
    this.description,
    this.image,
    this.ratings,
    required this.ratingCount,
    this.avgRating,
    this.projectCreator,
    this.completeOrdersCount,
  });

  factory Project.fromJson(json) => Project(
        id: json["id"],
        title: json["title"],
        slug: json["slug"],
        userId: json["user_id"],
        basicRegularCharge: json["basic_regular_charge"].toString().tryToParse,
        basicDiscountCharge:
            num.tryParse(json["basic_discount_charge"].toString()),
        basicDelivery: json["basic_delivery"],
        ratingCount: json["ratings_count"].toString().tryToParse,
        avgRating: json["ratings_avg_rating"].toString().tryToParse,
        description: json["description"],
        image: json["image"],
        completeOrdersCount:
            json["complete_orders_count"].toString().tryToParse,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "slug": slug,
        "user_id": userId,
        "basic_regular_charge": basicRegularCharge,
        "basic_discount_charge": basicDiscountCharge,
        "basic_delivery": basicDelivery,
        "description": description,
        "image": image,
        "ratings": ratings == null
            ? []
            : List<dynamic>.from(ratings!.map((x) => x.toJson())),
        "project_creator": projectCreator?.toJson(),
        "complete_orders_count": completeOrdersCount,
      };
}

class ProjectCreator {
  int? id;
  String? firstName;
  String? lastName;
  int? hourlyRate;
  String? experienceLevel;
  String? email;
  String? phone;
  String? username;
  String? image;
  int? countryId;
  int? stateId;
  int? cityId;
  int? userType;
  DateTime? checkOnlineStatus;
  int? checkWorkAvailability;
  int? userActiveInactiveStatus;
  int? userVerifiedStatus;
  int? isSuspend;
  int? termsCondition;
  dynamic about;
  String? isEmailVerified;
  String? google2FaSecret;
  int? google2FaEnableDisableDisable;
  dynamic googleId;
  dynamic facebookId;
  dynamic githubId;
  String? emailVerifyToken;
  String? firebaseDeviceToken;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

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
        checkOnlineStatus:
            DateTime.tryParse(json["check_online_status"].toString()),
        checkWorkAvailability: json["check_work_availability"],
        userActiveInactiveStatus: json["user_active_inactive_status"],
        userVerifiedStatus: json["user_verified_status"],
        isSuspend: json["is_suspend"],
        termsCondition: json["terms_condition"],
        about: json["about"],
        isEmailVerified: json["is_email_verified"],
        google2FaSecret: json["google_2fa_secret"],
        google2FaEnableDisableDisable:
            json["google_2fa_enable_disable_disable"],
        googleId: json["google_id"],
        facebookId: json["facebook_id"],
        githubId: json["github_id"],
        emailVerifyToken: json["email_verify_token"],
        firebaseDeviceToken: json["firebase_device_token"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.tryParse(json["created_at"].toString()),
        updatedAt: DateTime.tryParse(json["updated_at"].toString()),
        deletedAt: json["deleted_at"],
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
      };
}

class Rating {
  int? id;
  int? orderId;
  int? senderId;
  int? senderType;
  int? rating;
  dynamic reviewFeedback;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? laravelThroughKey;

  Rating({
    this.id,
    this.orderId,
    this.senderId,
    this.senderType,
    this.rating,
    this.reviewFeedback,
    this.createdAt,
    this.updatedAt,
    this.laravelThroughKey,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        orderId: json["order_id"],
        senderId: json["sender_id"],
        senderType: json["sender_type"],
        rating: json["rating"],
        reviewFeedback: json["review_feedback"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        laravelThroughKey: json["laravel_through_key"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "sender_id": senderId,
        "sender_type": senderType,
        "rating": rating,
        "review_feedback": reviewFeedback,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "laravel_through_key": laravelThroughKey,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
