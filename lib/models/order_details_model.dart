import 'dart:convert';

import 'package:xilancer/helper/extension/string_extension.dart';

import 'job_details_model.dart';
import 'my_orders_model.dart';

OrderDetailsModel orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) =>
    json.encode(data.toJson());

class OrderDetailsModel {
  Order? orderDetails;
  String? imagePath;
  String? attachmentPath;
  List<OrderMileStone>? orderMileStones;

  OrderDetailsModel({
    this.orderDetails,
    this.orderMileStones,
    this.imagePath,
    this.attachmentPath,
  });
  factory OrderDetailsModel.fromJson(Map json) => OrderDetailsModel(
        orderDetails: json["order_details"] == null
            ? null
            : Order.fromJson(json["order_details"]),
        orderMileStones: json["mile_stones"] == null
            ? []
            : List<OrderMileStone>.from(
                json["mile_stones"]!.map((x) => OrderMileStone.fromJson(x))),
        imagePath: json["image_path"],
        attachmentPath: json["order_submit_history_path"],
      );

  Map<String, dynamic> toJson() => {
        "order_details": orderDetails?.toJson(),
        "image_path": imagePath,
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
  num? revision;
  num? revisionLeft;
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
  ItemInfo? project;
  ItemInfo? job;
  Freelancer? freelancer;
  List<OrderSubmitHistory>? orderSubmitHistory;

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
    required this.revision,
    required this.revisionLeft,
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
    this.freelancer,
    this.manualPaymentImage,
    this.createdAt,
    this.updatedAt,
    this.rating,
    this.user,
    this.orderSubmitHistory,
    this.job,
    this.project,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        userId: json["user_id"],
        freelancerId: json["freelancer_id"],
        identity: json["identity"],
        project:
            json["project"] == null ? null : ItemInfo.fromJson(json["project"]),
        job: json["job"] == null ? null : ItemInfo.fromJson(json["job"]),
        isProjectJob: json["is_project_job"],
        isBasicStandardPremiumCustom: json["is_basic_standard_premium_custom"],
        isFixedHourly: json["is_fixed_hourly"],
        isCustom: json["is_custom"].toString() == "1",
        status: json["status"],
        statusBeforeHold: json["status_before_hold"],
        revision: json["revision"] is String
            ? num.tryParse(json["revision"].toString())
            : json["revision"],
        revisionLeft: json["revision_left"] is String
            ? num.tryParse(json["revision_left"].toString())
            : json["revision_left"],
        deliveryTime: json["delivery_time"],
        description: json["description"],
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
        orderSubmitHistory: json["order_submit_history"] == null
            ? []
            : List<OrderSubmitHistory>.from(json["order_submit_history"]!
                .map((x) => OrderSubmitHistory.fromJson(x))),
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

class OrderSubmitHistory {
  dynamic id;
  dynamic orderId;
  dynamic orderMilestoneId;
  String? attachment;
  dynamic status;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  OrderSubmitHistory({
    this.id,
    this.orderId,
    this.orderMilestoneId,
    this.attachment,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory OrderSubmitHistory.fromJson(Map<String, dynamic> json) =>
      OrderSubmitHistory(
        id: json["id"],
        orderId: json["order_id"],
        orderMilestoneId: json["order_milestone_id"],
        attachment: json["attachment"],
        status: json["status"],
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
        "order_id": orderId,
        "order_milestone_id": orderMilestoneId,
        "attachment": attachment,
        "status": status,
        "description": description,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class OrderMileStone {
  dynamic id;
  dynamic orderId;
  String? title;
  String? description;
  num? price;
  String? deadline;
  dynamic status;
  dynamic revision;
  dynamic revisionLeft;
  String? attachment;

  OrderMileStone({
    this.id,
    this.orderId,
    this.title,
    this.description,
    this.price,
    this.deadline,
    this.status,
    this.revision,
    this.revisionLeft,
    this.attachment,
  });

  factory OrderMileStone.fromJson(Map<String, dynamic> json) => OrderMileStone(
        id: json["id"],
        orderId: json["order_id"],
        title: json["title"],
        description: json["description"],
        price: json["price"].toString().tryToParse,
        deadline: json["deadline"],
        status: json["status"],
        revision: json["revision"],
        revisionLeft: json["revision_left"],
        attachment: json["attachment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "title": title,
        "description": description,
        "price": price,
        "deadline": deadline,
        "status": status,
        "revision": revision,
        "revision_left": revisionLeft,
        "attachment": attachment,
      };
}
