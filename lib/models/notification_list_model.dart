import 'dart:convert';

NotificationListModel notificationListModelFromJson(String str) =>
    NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) =>
    json.encode(data.toJson());

class NotificationListModel {
  List<Notification>? notifications;
  String? nexPageUrl;

  NotificationListModel({
    this.notifications,
    this.nexPageUrl,
  });

  factory NotificationListModel.fromJson(Map json) => NotificationListModel(
      notifications: json["data"] == null
          ? []
          : List<Notification>.from(
              json["data"]!.map((x) => Notification.fromJson(x))),
      nexPageUrl: json["next_page_url"]);

  Map<String, dynamic> toJson() => {
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class Notification {
  dynamic id;
  dynamic identity;
  dynamic freelancerId;
  Type? type;
  String? message;
  IsRead? isRead;
  DateTime? createdAt;
  DateTime? updatedAt;

  Notification({
    this.id,
    this.identity,
    this.freelancerId,
    this.type,
    this.message,
    this.isRead,
    this.createdAt,
    this.updatedAt,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        identity: json["identity"],
        freelancerId: json["freelancer_id"],
        type: typeValues.map[json["type"]]!,
        message: json["message"],
        isRead: isReadValues.map[json["is_read"]]!,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "identity": identity,
        "freelancer_id": freelancerId,
        "type": typeValues.reverse[type],
        "message": message,
        "is_read": isReadValues.reverse[isRead],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

enum IsRead { READ, UNREAD }

final isReadValues = EnumValues({
  "read": IsRead.READ,
  "unread": IsRead.UNREAD,
});

enum Type { ORDER, WITHDRAW }

final typeValues = EnumValues({"Order": Type.ORDER, "Withdraw": Type.WITHDRAW});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
