import 'dart:convert';

ChatListModel chatListModelFromJson(String str) =>
    ChatListModel.fromJson(json.decode(str));

String chatListModelToJson(ChatListModel data) => json.encode(data.toJson());

class ChatListModel {
  ChatList? chatList;
  String? profileImagePath;
  List? activeUsers;
  Map activityCheck;

  ChatListModel({
    this.chatList,
    this.profileImagePath,
    this.activeUsers,
    required this.activityCheck,
  });

  factory ChatListModel.fromJson(Map json) => ChatListModel(
        chatList: json["chat_list"] == null
            ? null
            : ChatList.fromJson(json["chat_list"]),
        profileImagePath: json["profile_image_path"],
        activeUsers: json["active_users"] == null
            ? []
            : List.from(json["active_users"]!.map((x) => x.toString())),
        activityCheck:
            json["activity_check"] is! Map ? {} : json["activity_check"],
      );

  Map<String, dynamic> toJson() => {
        "chat_list": chatList?.toJson(),
        "profile_image_path": profileImagePath,
        "active_users": activeUsers == null
            ? []
            : List<dynamic>.from(activeUsers!.map((x) => x)),
      };
}

class ChatList {
  List<Chats>? chats;
  dynamic nextPageUrl;

  ChatList({
    this.chats,
    this.nextPageUrl,
  });

  factory ChatList.fromJson(Map<String, dynamic> json) => ChatList(
        chats: json["data"] == null
            ? []
            : List<Chats>.from(json["data"]!.map((x) => Chats.fromJson(x))),
        nextPageUrl: json["next_page_url"],
      );

  Map<String, dynamic> toJson() => {
        "data": chats == null
            ? []
            : List<dynamic>.from(chats!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
      };
}

class Chats {
  dynamic id;
  dynamic clientId;
  dynamic freelancerId;
  dynamic adminId;
  DateTime? createdAt;
  DateTime? updatedAt;
  num clientUnseenMsgCount;
  num freelancerUnseenMsgCount;
  Client? client;
  Client? freelancer;

  Chats({
    this.id,
    this.clientId,
    this.freelancerId,
    this.adminId,
    this.createdAt,
    this.updatedAt,
    required this.clientUnseenMsgCount,
    required this.freelancerUnseenMsgCount,
    this.client,
    this.freelancer,
  });

  factory Chats.fromJson(Map<String, dynamic> json) => Chats(
        id: json["id"],
        clientId: json["client_id"],
        freelancerId: json["freelancer_id"],
        adminId: json["admin_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        clientUnseenMsgCount:
            num.tryParse(json["client_unseen_msg_count"].toString()) ?? 0,
        freelancerUnseenMsgCount:
            num.tryParse(json["freelancer_unseen_msg_count"].toString()) ?? 0,
        client: json["client"] == null ? null : Client.fromJson(json["client"]),
        freelancer: json["freelancer"] == null
            ? null
            : Client.fromJson(json["freelancer"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "client_id": clientId,
        "freelancer_id": freelancerId,
        "admin_id": adminId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "client_unseen_msg_count": clientUnseenMsgCount,
        "freelancer_unseen_msg_count": freelancerUnseenMsgCount,
        "client": client?.toJson(),
        "freelancer": freelancer?.toJson(),
      };
}

class Client {
  dynamic id;
  String? firstName;
  String? lastName;
  String image;

  Client({
    this.id,
    this.firstName,
    this.lastName,
    required this.image,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        image: json["image"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "image": image,
      };
}
