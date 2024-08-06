import 'dart:convert';

TicketChatModel ticketListModelFromJson(String str) =>
    TicketChatModel.fromJson(json.decode(str));

class TicketChatModel {
  TicketChatModel({
    required this.ticketDetails,
    required this.allMessages,
    this.aPath,
  });

  TicketDetails ticketDetails;
  List<AllMessage> allMessages;
  String? aPath;

  factory TicketChatModel.fromJson(Map json) => TicketChatModel(
      ticketDetails: TicketDetails.fromJson(json["ticket_details"]),
      allMessages: json["ticket_details"]["message"] == null
          ? []
          : List<AllMessage>.from(json["ticket_details"]["message"]
              .map((x) => AllMessage.fromJson(x))),
      aPath: json["attachment_path"]);
}

class AllMessage {
  AllMessage({
    required this.id,
    required this.message,
    required this.notify,
    this.attachment,
    required this.type,
    required this.supportTicketId,
  });

  dynamic id;
  String? message;
  dynamic notify;
  String? attachment;
  dynamic type;
  dynamic supportTicketId;

  factory AllMessage.fromJson(Map json) => AllMessage(
        id: json["id"],
        message: json["message"],
        notify: json["notify"],
        attachment: json["attachment"]?.toString().trim() == ""
            ? null
            : json["attachment"],
        type: json["type"],
        supportTicketId: json["support_ticket_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "notify": notify,
        "attachment": attachment,
        "type": type,
        "support_ticket_id": supportTicketId,
      };
}

class TicketDetails {
  TicketDetails({
    required this.id,
    required this.title,
    this.via,
    this.operatingSystem,
    required this.userAgent,
    required this.description,
    required this.subject,
    required this.status,
    required this.priority,
    required this.departments,
    required this.userId,
    this.adminId,
  });

  dynamic id;
  String? title;
  dynamic via;
  dynamic operatingSystem;
  var userAgent;
  String? description;
  String? subject;
  String? status;
  String? priority;
  dynamic departments;
  dynamic userId;
  dynamic adminId;

  factory TicketDetails.fromJson(Map<String, dynamic> json) => TicketDetails(
        id: json["id"],
        title: json["title"],
        via: json["via"],
        operatingSystem: json["operating_system"],
        userAgent: json["user_agent"],
        description: json["description"],
        subject: json["subject"],
        status: json["status"],
        priority: json["priority"],
        departments: json["departments"],
        userId: json["user_id"],
        adminId: json["admin_id"],
      );
}
