import 'dart:convert';

import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/models/offer_details_model.dart';

import 'project_list_model.dart';

ProfileDetailsModel profileDetailsModelFromJson(String str) =>
    ProfileDetailsModel.fromJson(json.decode(str));

String profileDetailsModelToJson(ProfileDetailsModel data) =>
    json.encode(data.toJson());

class ProfileDetailsModel {
  String? username;
  String? profileImagePath;
  var reviewRatings;
  var reviewFeedbacks;
  var reviewProjects;
  num? avgRating;
  num? activeOrderCount;
  num? totalRating;
  List<SkillsAccordingToCategory>? skillsAccordingToCategory;
  List<Portfolio>? portfolios;
  String? portfolioPath;
  String? skills;
  List<Education>? educations;
  List<Experience>? experiences;
  List<Project>? projects;
  String? projectPath;
  String? timeZone;
  User? user;
  TotalEarning? totalEarning;
  List<CompleteOrder>? completeOrders;

  ProfileDetailsModel({
    this.username,
    this.reviewRatings,
    this.reviewFeedbacks,
    this.reviewProjects,
    this.profileImagePath,
    this.avgRating,
    this.activeOrderCount,
    this.totalRating,
    this.skillsAccordingToCategory,
    this.portfolios,
    this.portfolioPath,
    this.skills,
    this.educations,
    this.experiences,
    this.projects,
    this.projectPath,
    this.timeZone,
    this.user,
    this.totalEarning,
    this.completeOrders,
  });

  factory ProfileDetailsModel.fromJson(Map json) => ProfileDetailsModel(
        username: json["username"],
        reviewRatings: json["review_rating"]
            ?.map((e) => e is String ? e.toString().tryToParse : e?.toDouble())
            .toList(),
        reviewFeedbacks: json["review_feedback"] ?? [],
        reviewProjects: json["review_project"] ?? [],
        profileImagePath: json["profile_image_path"],
        activeOrderCount: json["active_orders_count"],
        timeZone: json["timezone"],
        avgRating: json["freelancer_avg_rating"].toString().tryToParse,
        totalRating: json["freelancer_total_rating"].toString().tryToParse,
        skillsAccordingToCategory: json["skills_according_to_category"] is! List
            ? []
            : List<SkillsAccordingToCategory>.from(
                json["skills_according_to_category"]!
                    .map((x) => SkillsAccordingToCategory.fromJson(x))),
        portfolios: json["portfolios"] == null
            ? []
            : List<Portfolio>.from(
                json["portfolios"]!.map((x) => Portfolio.fromJson(x))),
        portfolioPath: json["portfolio_file_path"],
        skills: json["skills"],
        educations: json["educations"] == null
            ? []
            : List<Education>.from(
                json["educations"]!.map((x) => Education.fromJson(x))),
        experiences: json["experiences"] == null
            ? []
            : List<Experience>.from(
                json["experiences"]!.map((x) => Experience.fromJson(x))),
        projects: json["projects"] == null
            ? []
            : List<Project>.from(
                json["projects"]!.map((x) => Project.fromJson(x))),
        projectPath: json["project_file_path"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        totalEarning: json["total_earning"] == null
            ? null
            : TotalEarning.fromJson(json["total_earning"]),
        completeOrders: json["complete_orders"] == null
            ? []
            : List<CompleteOrder>.from(
                json["complete_orders"]!.map((x) => CompleteOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "skills_according_to_category": skillsAccordingToCategory == null
            ? []
            : List<dynamic>.from(
                skillsAccordingToCategory!.map((x) => x.toJson())),
        "portfolios": portfolios == null
            ? []
            : List<dynamic>.from(portfolios!.map((x) => x.toJson())),
        "portfolio_path": portfolioPath,
        "skills": skills,
        "educations": educations == null
            ? []
            : List<dynamic>.from(educations!.map((x) => x.toJson())),
        "experiences": experiences == null
            ? []
            : List<dynamic>.from(experiences!.map((x) => x.toJson())),
        "projects": projects == null
            ? []
            : List<dynamic>.from(projects!.map((x) => x.toJson())),
        "project_path": projectPath,
        "user": user?.toJson(),
        "total_earning": totalEarning?.toJson(),
        "complete_orders": completeOrders == null
            ? []
            : List<dynamic>.from(completeOrders!.map((x) => x.toJson())),
      };
}

class CompleteOrder {
  dynamic id;
  dynamic identity;
  dynamic status;

  CompleteOrder({
    this.id,
    this.identity,
    this.status,
  });

  factory CompleteOrder.fromJson(Map<String, dynamic> json) => CompleteOrder(
        id: json["id"],
        identity: json["identity"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identity": identity,
        "status": status,
      };
}

class Education {
  dynamic id;
  dynamic userId;
  String? institution;
  String? degree;
  String? subject;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Education({
    this.id,
    this.userId,
    this.institution,
    this.degree,
    this.subject,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        id: json["id"],
        userId: json["user_id"],
        institution: json["institution"],
        degree: json["degree"],
        subject: json["subject"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
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
        "institution": institution,
        "degree": degree,
        "subject": subject,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Experience {
  dynamic id;
  dynamic userId;
  String? title;
  String? shortDescription;
  String? organization;
  String? address;
  dynamic countryId;
  dynamic stateId;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Experience({
    this.id,
    this.userId,
    this.title,
    this.shortDescription,
    this.organization,
    this.address,
    this.countryId,
    this.stateId,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Experience.fromJson(Map<String, dynamic> json) => Experience(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        shortDescription: json["short_description"],
        organization: json["organization"],
        address: json["address"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
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
        "short_description": shortDescription,
        "organization": organization,
        "address": address,
        "country_id": countryId,
        "state_id": stateId,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Portfolio {
  dynamic id;
  dynamic userId;
  String? username;
  String? image;
  String? title;
  String? description;
  dynamic publishedDate;
  DateTime? createdAt;
  DateTime? updatedAt;

  Portfolio({
    this.id,
    this.userId,
    this.username,
    this.image,
    this.title,
    this.description,
    this.publishedDate,
    this.createdAt,
    this.updatedAt,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        id: json["id"],
        userId: json["user_id"],
        username: json["username"],
        image: json["image"],
        title: json["title"],
        description: json["description"],
        publishedDate: json["published_date"],
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
        "username": username,
        "image": image,
        "title": title,
        "description": description,
        "published_date": publishedDate,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

// class Project {
//   dynamic id;
//   dynamic userId;
//   dynamic categoryId;
//   String? title;
//   String? slug;
//   String? description;
//   String? image;
//   String? basicTitle;
//   String? standardTitle;
//   String? premiumTitle;
//   String? basicRevision;
//   String? standardRevision;
//   String? premiumRevision;
//   String? basicDelivery;
//   String? standardDelivery;
//   String? premiumDelivery;
//   num? basicRegularCharge;
//   num? basicDiscountCharge;
//   num? standardRegularCharge;
//   num? standardDiscountCharge;
//   num? premiumRegularCharge;
//   num? premiumDiscountCharge;
//   dynamic rating;
//   dynamic projectOnOff;
//   dynamic projectApproveRequest;
//   dynamic status;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   Project({
//     this.id,
//     this.userId,
//     this.categoryId,
//     this.title,
//     this.slug,
//     this.description,
//     this.image,
//     this.basicTitle,
//     this.standardTitle,
//     this.premiumTitle,
//     this.basicRevision,
//     this.standardRevision,
//     this.premiumRevision,
//     this.basicDelivery,
//     this.standardDelivery,
//     this.premiumDelivery,
//     this.basicRegularCharge,
//     this.basicDiscountCharge,
//     this.standardRegularCharge,
//     this.standardDiscountCharge,
//     this.premiumRegularCharge,
//     this.premiumDiscountCharge,
//     this.projectOnOff,
//     this.projectApproveRequest,
//     this.status,
//     this.rating,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Project.fromJson(Map<String, dynamic> json) => Project(
//         id: json["id"],
//         userId: json["user_id"],
//         categoryId: json["category_id"],
//         rating: json["ratings_avg_rating"],
//         title: json["title"],
//         slug: json["slug"],
//         description: json["description"],
//         image: json["image"],
//         basicTitle: json["basic_title"],
//         standardTitle: json["standard_title"],
//         premiumTitle: json["premium_title"],
//         basicRevision: json["basic_revision"],
//         standardRevision: json["standard_revision"],
//         premiumRevision: json["premium_revision"],
//         basicDelivery: json["basic_delivery"],
//         standardDelivery: json["standard_delivery"],
//         premiumDelivery: json["premium_delivery"],
//         basicRegularCharge: json["basic_regular_charge"] is String
//             ? num.tryParse(json["basic_regular_charge"])
//             : json["basic_regular_charge"],
//         basicDiscountCharge: json["basic_discount_charge"] is String
//             ? num.tryParse(json["basic_discount_charge"])
//             : json["basic_discount_charge"],
//         standardRegularCharge: json["standard_regular_charge"] is String
//             ? num.tryParse(json["standard_regular_charge"])
//             : json["standard_regular_charge"],
//         standardDiscountCharge: json["standard_discount_charge"] is String
//             ? num.tryParse(json["standard_discount_charge"])
//             : json["standard_discount_charge"],
//         premiumRegularCharge: json["premium_regular_charge"] is String
//             ? num.tryParse(json["premium_regular_charge"])
//             : json["premium_regular_charge"],
//         premiumDiscountCharge: json["premium_discount_charge"] is String
//             ? num.tryParse(json["premium_discount_charge"])
//             : json["premium_discount_charge"],
//         projectOnOff: json["project_on_off"],
//         projectApproveRequest: json["project_approve_request"],
//         status: json["status"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "user_id": userId,
//         "category_id": categoryId,
//         "title": title,
//         "slug": slug,
//         "description": description,
//         "image": image,
//         "basic_title": basicTitle,
//         "standard_title": standardTitle,
//         "premium_title": premiumTitle,
//         "basic_revision": basicRevision,
//         "standard_revision": standardRevision,
//         "premium_revision": premiumRevision,
//         "basic_delivery": basicDelivery,
//         "standard_delivery": standardDelivery,
//         "premium_delivery": premiumDelivery,
//         "basic_regular_charge": basicRegularCharge,
//         "basic_discount_charge": basicDiscountCharge,
//         "standard_regular_charge": standardRegularCharge,
//         "standard_discount_charge": standardDiscountCharge,
//         "premium_regular_charge": premiumRegularCharge,
//         "premium_discount_charge": premiumDiscountCharge,
//         "project_on_off": projectOnOff,
//         "project_approve_request": projectApproveRequest,
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }

class SkillsAccordingToCategory {
  dynamic id;
  String? skill;

  SkillsAccordingToCategory({
    this.id,
    this.skill,
  });

  factory SkillsAccordingToCategory.fromJson(Map<String, dynamic> json) =>
      SkillsAccordingToCategory(
        id: json["id"],
        skill: json["skill"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "skill": skill,
      };
}

class TotalEarning {
  dynamic id;
  dynamic userId;
  num? totalEarning;
  num? totalWithdraw;
  num? remainingBalance;

  TotalEarning({
    this.id,
    this.userId,
    this.totalEarning,
    this.totalWithdraw,
    this.remainingBalance,
  });

  factory TotalEarning.fromJson(Map<String, dynamic> json) => TotalEarning(
        id: json["id"],
        userId: json["user_id"],
        totalEarning: json["total_earning"] is String
            ? num.tryParse(json["total_earning"])
            : json["total_earning"],
        totalWithdraw: json["total_withdraw"] is String
            ? num.tryParse(json["total_withdraw"])
            : json["total_withdraw"],
        remainingBalance: json["remaining_balance"] is String
            ? num.tryParse(json["remaining_balance"])
            : json["remaining_balance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "total_earning": totalEarning,
        "total_withdraw": totalWithdraw,
        "remaining_balance": remainingBalance,
      };
}

class User {
  dynamic id;
  String? image;
  num? hourlyRate;
  String? firstName;
  String? lastName;
  String? username;
  dynamic countryId;
  dynamic stateId;
  dynamic checkWorkAvailability;
  UserCountry? userCountry;
  UserState? userState;

  UserIntroduction? userIntroduction;

  User({
    this.id,
    this.image,
    this.userCountry,
    this.userState,
    this.hourlyRate,
    this.firstName,
    this.lastName,
    this.username,
    this.countryId,
    this.stateId,
    this.checkWorkAvailability,
    this.userIntroduction,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        userCountry: json["user_country"] == null
            ? null
            : UserCountry.fromJson(json["user_country"]),
        userState: json["user_state"] == null
            ? null
            : UserState.fromJson(json["user_state"]),
        image: json["image"],
        hourlyRate: json["hourly_rate"] is String
            ? num.tryParse(json["hourly_rate"])
            : json["hourly_rate"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        username: json["username"],
        countryId: json["country_id"],
        stateId: json["state_id"],
        checkWorkAvailability: json["check_work_availability"],
        userIntroduction: json["user_introduction"] == null
            ? null
            : UserIntroduction.fromJson(json["user_introduction"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "hourly_rate": hourlyRate,
        "first_name": firstName,
        "last_name": lastName,
        "username": username,
        "country_id": countryId,
        "state_id": stateId,
        "check_work_availability": checkWorkAvailability,
        "user_introduction": userIntroduction?.toJson(),
      };
}

class UserIntroduction {
  dynamic id;
  dynamic userId;
  String? title;
  String? description;

  UserIntroduction({
    this.id,
    this.userId,
    this.title,
    this.description,
  });

  factory UserIntroduction.fromJson(Map<String, dynamic> json) =>
      UserIntroduction(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
      };
}
