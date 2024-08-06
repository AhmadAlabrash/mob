// To parse this JSON data, do
//
//     final offerDetailsModel = offerDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:xilancer/models/order_details_model.dart';

OfferDetailsModel offerDetailsModelFromJson(String str) =>
    OfferDetailsModel.fromJson(json.decode(str));

String offerDetailsModelToJson(OfferDetailsModel data) =>
    json.encode(data.toJson());

class OfferDetailsModel {
  OfferDetails? offerDetails;
  String? freelancerCountry;
  String? freelancerState;
  num completeOrdersCount;
  num avgRating;
  num ratingCount;

  OfferDetailsModel({
    this.offerDetails,
    this.freelancerCountry,
    this.freelancerState,
    required this.completeOrdersCount,
    required this.avgRating,
    required this.ratingCount,
  });

  factory OfferDetailsModel.fromJson(json) => OfferDetailsModel(
        offerDetails: json["offer_details"] == null
            ? null
            : OfferDetails.fromJson(json["offer_details"]),
        freelancerCountry: json["freelancer_country"],
        freelancerState: json["freelancer_state"],
        completeOrdersCount: json["complete_orders_count"],
        avgRating: json["avg_rating"]?.toDouble(),
        ratingCount: json["rating_count"],
      );

  Map<String, dynamic> toJson() => {
        "offer_details": offerDetails?.toJson(),
        "freelancer_country": freelancerCountry,
        "freelancer_state": freelancerState,
        "complete_orders_count": completeOrdersCount,
        "avg_rating": avgRating,
        "rating_count": ratingCount,
      };
}

class OfferDetails {
  dynamic id;
  dynamic freelancerId;
  dynamic clientId;
  num price;
  dynamic description;
  dynamic deadline;
  dynamic status;
  num revision;
  num revisionLeft;
  dynamic attachment;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<OrderMileStone>? milestones;
  Freelancer? freelancer;

  OfferDetails({
    this.id,
    this.freelancerId,
    this.clientId,
    required this.price,
    this.description,
    this.deadline,
    this.status,
    required this.revision,
    required this.revisionLeft,
    this.attachment,
    this.createdAt,
    this.updatedAt,
    this.milestones,
    this.freelancer,
  });

  factory OfferDetails.fromJson(Map<String, dynamic> json) => OfferDetails(
        id: json["id"],
        freelancerId: json["freelancer_id"],
        clientId: json["client_id"],
        price: json["price"],
        description: json["description"],
        deadline: json["deadline"],
        status: json["status"],
        revision: json["revision"],
        revisionLeft: json["revision_left"],
        attachment: json["attachment"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        milestones: json["milestones"] == null
            ? []
            : List<OrderMileStone>.from(
                json["milestones"]!.map((x) => OrderMileStone.fromJson(x))),
        freelancer: json["freelancer"] == null
            ? null
            : Freelancer.fromJson(json["freelancer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "freelancer_id": freelancerId,
        "client_id": clientId,
        "price": price,
        "description": description,
        "deadline": deadline,
        "status": status,
        "revision": revision,
        "revision_left": revisionLeft,
        "attachment": attachment,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "milestones": milestones == null
            ? []
            : List<dynamic>.from(milestones!.map((x) => x.toJson())),
        "freelancer": freelancer?.toJson(),
      };
}

class Freelancer {
  dynamic id;
  String? firstName;
  String? lastName;
  String? image;
  dynamic userVerifiedStatus;
  DateTime? checkOnlineStatus;
  dynamic countryId;
  dynamic stateId;
  UserCountry? userCountry;
  UserState? userState;

  Freelancer({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
    this.userVerifiedStatus,
    this.checkOnlineStatus,
    this.countryId,
    this.stateId,
    this.userCountry,
    this.userState,
  });

  factory Freelancer.fromJson(Map<String, dynamic> json) => Freelancer(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
        userVerifiedStatus: json["user_verified_status"],
        checkOnlineStatus: json["check_online_status"] == null
            ? null
            : DateTime.parse(json["check_online_status"]),
        countryId: json["country_id"],
        stateId: json["state_id"],
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
        "user_verified_status": userVerifiedStatus,
        "check_online_status": checkOnlineStatus?.toIso8601String(),
        "country_id": countryId,
        "state_id": stateId,
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

// class Milestone {
//   dynamic id;
//   dynamic offerId;
//   String? title;
//   String? description;
//   num price;
//   String? deadline;
//   dynamic status;
//   num revision;
//   num revisionLeft;
//   dynamic attachment;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   Milestone({
//     this.id,
//     this.offerId,
//     this.title,
//     this.description,
//     required this.price,
//     this.deadline,
//     this.status,
//     required this.revision,
//     required this.revisionLeft,
//     this.attachment,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory Milestone.fromJson(Map<String, dynamic> json) => Milestone(
//         id: json["id"],
//         offerId: json["offer_id"],
//         title: json["title"],
//         description: json["description"],
//         price: json["price"],
//         deadline: json["deadline"],
//         status: json["status"],
//         revision: json["revision"],
//         revisionLeft: json["revision_left"],
//         attachment: json["attachment"],
//         createdAt: json["created_at"] == null
//             ? null
//             : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null
//             ? null
//             : DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "offer_id": offerId,
//         "title": title,
//         "description": description,
//         "price": price,
//         "deadline": deadline,
//         "status": status,
//         "revision": revision,
//         "revision_left": revisionLeft,
//         "attachment": attachment,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//       };
// }
