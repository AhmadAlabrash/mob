import 'dart:convert';

import 'job_details_model.dart';

MyOffersModel myOffersModelFromJson(String str) =>
    MyOffersModel.fromJson(json.decode(str));

String myOffersModelToJson(MyOffersModel data) => json.encode(data.toJson());

class MyOffersModel {
  MyOffers? myOffers;
  String? profileImagePath;

  MyOffersModel({
    this.myOffers,
    this.profileImagePath,
  });

  factory MyOffersModel.fromJson(Map json) => MyOffersModel(
        myOffers:
            json["offers"] == null ? null : MyOffers.fromJson(json["offers"]),
        profileImagePath: json["profile_image_path"],
      );

  Map<String, dynamic> toJson() => {
        "my_offers": myOffers?.toJson(),
        "profile_image_path": profileImagePath,
      };
}

class MyOffers {
  List<Offer>? data;
  dynamic nextPageUrl;

  MyOffers({
    this.data,
    this.nextPageUrl,
  });

  factory MyOffers.fromJson(Map<String, dynamic> json) => MyOffers(
        data: json["data"] == null
            ? []
            : List<Offer>.from(json["data"]!.map((x) => Offer.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class Offer {
  dynamic id;
  dynamic freelancerId;
  dynamic clientId;
  num? price;
  String? description;
  String? deadline;
  dynamic status;
  dynamic revision;
  dynamic revisionLeft;
  dynamic attachment;
  DateTime? createdAt;
  DateTime? updatedAt;
  Client? client;
  Freelancer? freelancer;

  Offer({
    this.id,
    this.freelancerId,
    this.clientId,
    this.price,
    this.description,
    this.deadline,
    this.status,
    this.revision,
    this.revisionLeft,
    this.attachment,
    this.createdAt,
    this.updatedAt,
    this.client,
    this.freelancer,
  });

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        id: json["id"],
        freelancerId: json["freelancer_id"],
        clientId: json["client_id"],
        price: num.tryParse(json["price"].toString()) ?? 0,
        description: json["description"],
        deadline: json["deadline"],
        status: json["status"],
        revision: json["revision"],
        revisionLeft: json["revision_left"],
        attachment: json["attachment"],
        createdAt: DateTime.tryParse(json["created_at"].toString()),
        updatedAt: DateTime.tryParse(json["updated_at"].toString()),
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
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
        "client": client?.toJson(),
      };
}

class Client {
  dynamic id;
  String? firstName;
  String? lastName;
  String? image;

  Client({
    this.id,
    this.firstName,
    this.lastName,
    this.image,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
      };
}
