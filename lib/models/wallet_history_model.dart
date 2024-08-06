import 'dart:convert';

WalletHistoryModel walletHistoryModelFromJson(String str) =>
    WalletHistoryModel.fromJson(json.decode(str));

String walletHistoryModelToJson(WalletHistoryModel data) =>
    json.encode(data.toJson());

class WalletHistoryModel {
  Histories? histories;
  num? walletBalance;

  WalletHistoryModel({
    this.histories,
    this.walletBalance,
  });

  factory WalletHistoryModel.fromJson(Map json) => WalletHistoryModel(
        histories: json["histories"] == null
            ? null
            : Histories.fromJson(json["histories"]),
        walletBalance: json["wallet_balance"] is String
            ? num.tryParse(json["wallet_balance"].toString())
            : json["wallet_balance"],
      );

  Map<String, dynamic> toJson() => {
        "histories": histories?.toJson(),
        "wallet_balance": walletBalance,
      };
}

class Histories {
  List<History>? data;
  dynamic nextPageUrl;

  Histories({
    this.data,
    this.nextPageUrl,
  });

  factory Histories.fromJson(Map<String, dynamic> json) => Histories(
        data: json["data"] == null
            ? []
            : List<History>.from(json["data"]!.map((x) => History.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class History {
  dynamic id;
  dynamic userId;
  String? paymentGateway;
  String paymentStatus;
  num? amount;
  String? transactionId;
  String? manualPaymentImage;
  dynamic status;
  DateTime? createdAt;
  DateTime? updatedAt;

  History({
    this.id,
    this.userId,
    this.paymentGateway,
    required this.paymentStatus,
    this.amount,
    this.transactionId,
    this.manualPaymentImage,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        userId: json["user_id"],
        paymentGateway: json["payment_gateway"],
        paymentStatus: json["payment_status"] ?? "",
        amount: json["amount"] is String
            ? num.tryParse(json["amount"].toString())
            : json["amount"],
        transactionId: json["transaction_id"],
        manualPaymentImage: json["manual_payment_image"],
        status: json["status"],
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
        "payment_gateway": paymentGateway,
        "payment_status": paymentStatus,
        "amount": amount,
        "transaction_id": transactionId,
        "manual_payment_image": manualPaymentImage,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
