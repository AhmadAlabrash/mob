import 'dart:convert';

import 'package:xilancer/models/job_details_model.dart';

MyOrdersModel myOrdersModelFromJson(String str) =>
    MyOrdersModel.fromJson(json.decode(str));

String myOrdersModelToJson(MyOrdersModel data) => json.encode(data.toJson());

class MyOrdersModel {
  OrdersList? ordersList;
  dynamic totalCount;
  dynamic queueOrders;
  dynamic activeOrders;
  dynamic completeOrders;
  dynamic cancelOrders;
  String? imagePath;

  MyOrdersModel({
    this.ordersList,
    this.totalCount,
    this.queueOrders,
    this.activeOrders,
    this.completeOrders,
    this.cancelOrders,
    this.imagePath,
  });

  factory MyOrdersModel.fromJson(Map json) => MyOrdersModel(
        ordersList:
            json["orders"] == null ? null : OrdersList.fromJson(json["orders"]),
        totalCount: json["total_count"],
        queueOrders: json["queue_orders"],
        activeOrders: json["active_orders"],
        completeOrders: json["complete_orders"],
        cancelOrders: json["cancel_orders"],
        imagePath: json["image_path"],
      );

  Map<String, dynamic> toJson() => {
        "orders": ordersList?.toJson(),
        "total_count": totalCount,
        "queue_orders": queueOrders,
        "active_orders": activeOrders,
        "complete_orders": completeOrders,
        "cancel_orders": cancelOrders,
        "image_path": imagePath,
      };
}

class OrdersList {
  List<Order>? data;
  dynamic nextPageUrl;

  OrdersList({
    this.data,
    this.nextPageUrl,
  });

  factory OrdersList.fromJson(Map<String, dynamic> json) => OrdersList(
        data: json["data"] == null
            ? []
            : List<Order>.from(json["data"]!.map((x) => Order.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class Order {
  dynamic id;
  dynamic userId;
  dynamic freelancerId;
  dynamic identity;
  dynamic isProjectJob;
  dynamic isBasicStandardPremiumCustom;
  dynamic isFixedHourly;
  bool isCustom;
  dynamic status;
  dynamic statusBeforeHold;
  dynamic revision;
  dynamic revisionLeft;
  dynamic deliveryTime;
  dynamic description;
  num? price;
  dynamic commissionType;
  num? commissionCharge;
  num? commissionAmount;
  dynamic transactionType;
  num? transactionCharge;
  num? transactionAmount;
  num? payableAmount;
  num? refundAmount;
  dynamic refundStatus;
  dynamic totalHour;
  String? paymentGateway;
  dynamic paymentStatus;
  dynamic transactionId;
  dynamic manualPaymentImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Rating>? rating;
  User? user;
  Freelancer? freelancer;
  ItemInfo? project;
  ItemInfo? job;

  Order({
    this.id,
    this.userId,
    this.freelancerId,
    this.identity,
    this.isProjectJob,
    this.isBasicStandardPremiumCustom,
    this.isFixedHourly,
    required this.isCustom,
    this.status,
    this.statusBeforeHold,
    this.revision,
    this.revisionLeft,
    this.deliveryTime,
    this.description,
    this.price,
    this.commissionType,
    this.commissionCharge,
    this.commissionAmount,
    this.transactionType,
    this.transactionCharge,
    this.transactionAmount,
    this.payableAmount,
    this.refundAmount,
    this.refundStatus,
    this.totalHour,
    this.paymentGateway,
    this.paymentStatus,
    this.transactionId,
    this.manualPaymentImage,
    this.project,
    this.job,
    this.createdAt,
    this.updatedAt,
    this.rating,
    this.user,
    this.freelancer,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        freelancerId: json["freelancer_id"],
        identity: json["identity"],
        isProjectJob: json["is_project_job"],
        isBasicStandardPremiumCustom: json["is_basic_standard_premium_custom"],
        isFixedHourly: json["is_fixed_hourly"],
        isCustom: json["is_custom"].toString() == "1",
        status: json["status"],
        statusBeforeHold: json["status_before_hold"],
        revision: json["revision"],
        revisionLeft: json["revision_left"],
        deliveryTime: json["delivery_time"],
        description: json["description"],
        project:
            json["project"] == null ? null : ItemInfo.fromJson(json["project"]),
        job: json["job"] == null ? null : ItemInfo.fromJson(json["job"]),
        price: json["price"] is String
            ? num.tryParse(json["price"].toString())
            : json["price"],
        commissionType: json["commission_type"],
        commissionCharge: json["commission_charge"] is String
            ? num.tryParse(json["commission_charge"].toString())
            : json["commission_charge"],
        commissionAmount: json["commission_amount"] is String
            ? num.tryParse(json["commission_amount"].toString())
            : json["commission_amount"],
        transactionType: json["transaction_type"],
        transactionCharge: json["transaction_charge"] is String
            ? num.tryParse(json["transaction_charge"].toString())
            : json["transaction_charge"],
        transactionAmount: json["transaction_amount"] is String
            ? num.tryParse(json["transaction_amount"].toString())
            : json["transaction_amount"],
        payableAmount: json["payable_amount"]?.toDouble() is String
            ? num.tryParse(json["payable_amount"].toString())
            : json["payable_amount"],
        refundAmount: json["refund_amount"] is String
            ? num.tryParse(json["refund_amount"].toString())
            : json["refund_amount"],
        refundStatus: json["refund_status"],
        totalHour: json["total_hour"],
        paymentGateway: json["payment_gateway"],
        paymentStatus: json["payment_status"],
        transactionId: json["transaction_id"],
        manualPaymentImage: json["manual_payment_image"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        rating: json["rating"] == null
            ? []
            : List<Rating>.from(json["rating"]!.map((x) => Rating.fromJson(x))),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        freelancer: json["freelancer"] == null
            ? null
            : Freelancer.fromJson(json["freelancer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "freelancer_id": freelancerId,
        "identity": identity,
        "is_project_job": isProjectJob,
        "is_basic_standard_premium_custom": isBasicStandardPremiumCustom,
        "is_fixed_hourly": isFixedHourly,
        "is_custom": isCustom,
        "status": status,
        "status_before_hold": statusBeforeHold,
        "revision": revision,
        "revision_left": revisionLeft,
        "delivery_time": deliveryTime,
        "description": description,
        "price": price,
        "commission_type": commissionType,
        "commission_charge": commissionCharge,
        "commission_amount": commissionAmount,
        "transaction_type": transactionType,
        "transaction_charge": transactionCharge,
        "transaction_amount": transactionAmount,
        "payable_amount": payableAmount,
        "refund_amount": refundAmount,
        "refund_status": refundStatus,
        "total_hour": totalHour,
        "payment_gateway": paymentGateway,
        "payment_status": paymentStatus,
        "transaction_id": transactionId,
        "manual_payment_image": manualPaymentImage,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "rating": rating == null
            ? []
            : List<dynamic>.from(rating!.map((x) => x.toJson())),
        "user": user?.toJson(),
      };
}

class Rating {
  dynamic id;
  dynamic orderId;
  num? rating;
  dynamic senderType;

  Rating({
    this.id,
    this.orderId,
    this.rating,
    this.senderType,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        id: json["id"],
        orderId: json["order_id"],
        rating: json["rating"] is String
            ? num.tryParse(json["rating"].toString())
            : json["rating"]?.toDouble(),
        senderType: json["sender_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "rating": rating,
        "sender_type": senderType,
      };
}

class User {
  dynamic id;
  String? image;
  String? fName;
  String? lName;

  User({
    this.id,
    this.image,
    this.fName,
    this.lName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        image: json["image"],
        fName: json["first_name"],
        lName: json["last_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

class ItemInfo {
  final dynamic id;
  final String? title;

  ItemInfo({this.id, this.title});

  factory ItemInfo.fromJson(json) => ItemInfo(
        id: json["id"],
        title: json["title"],
      );
}
