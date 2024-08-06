import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:xilancer/customizations.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

import '../../models/ticket_chat_model.dart';
import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';
import '../helper/constant_helper.dart';
import '../helper/local_keys.g.dart';

class TicketChatService with ChangeNotifier {
  List<AllMessage> messagesList = [];
  TicketDetails? ticketDetails;
  bool isLoading = false;
  String message = '';
  String attachmentPath = "";
  File? pickedImage;
  bool notifyViaMail = false;
  bool noMessage = false;
  bool msgSendingLoading = false;
  bool noMoreMessages = false;
  int nextPage = 2;
  bool nextPageLoading = false;

  setIsLoading(value) {
    isLoading = value;
    notifyListeners();
  }

  setMsgSendingLoading() {
    msgSendingLoading = true;
    notifyListeners();
  }

  setMessage(value) {
    message = value;
    notifyListeners();
  }

  clearAllMessages() {
    messagesList = [];
    pickedImage = null;
    notifyViaMail = false;
    noMessage = false;
    noMoreMessages = false;
    ticketDetails = null;
    notifyListeners();
  }

  setPickedImage(value) {
    pickedImage = value;
    notifyListeners();
  }

  toggleNotifyViaMail(value) {
    notifyViaMail = !notifyViaMail;
    notifyListeners();
  }

  Future fetchSingleTickets(BuildContext context, id) async {
    final url = "${AppUrls.fetchTicketChatUrl}/$id";
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.message, headers: commonAuthHeader);

    if (responseData != null) {
      final temTicketModel = TicketChatModel.fromJson(responseData);
      messagesList = temTicketModel.allMessages.reversed.toList();
      ticketDetails = temTicketModel.ticketDetails;
      noMessage = temTicketModel.allMessages.isEmpty;
      attachmentPath = temTicketModel.aPath ?? "";
      nextPage = 2;
      if (messagesList.length < 20) {
        noMoreMessages = true;
      }
    } else {}
    setIsLoading(false);
  }

  Future sendMessage(BuildContext context, id) async {
    final url = AppUrls.sendTicketMessageUrl;
    nextPageLoading = false;
    var headers = {'Authorization': 'Bearer $getToken'};
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
      'ticket_id': '$id',
      'message': message,
      'send_notify_mail': notifyViaMail ? 'on' : 'off'
    });
    if (pickedImage != null) {
      request.files.add(
          await http.MultipartFile.fromPath('attachment', pickedImage!.path));
    }
    request.headers.addAll(headers);

    final responseData = await NetworkApiServices()
        .postWithFileApi(request, LocalKeys.sendMessage);

    if (responseData != null) {
      messagesList.insert(0, AllMessage.fromJson(responseData));
      message = '';
      pickedImage = null;
      notifyViaMail = false;
    } else {}
    setIsLoading(false);
  }

  Future fetchOnlyMessages() async {
    nextPageLoading = true;
    notifyListeners();
    final url = "${AppUrls.stListUrl}/${ticketDetails?.id}?page=$nextPage";
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.message, headers: commonAuthHeader);

    if (responseData != null &&
        responseData["all_message"]["data"].isNotEmpty) {
      final tempData = responseData["all_message"]["data"];
      tempData.forEach((element) {
        messagesList.add(AllMessage.fromJson(element));
      });
      nextPage++;
    } else if (responseData != null &&
        responseData["all_message"]["data"].isEmpty) {
      LocalKeys.noMessageFound.showToast();
      noMoreMessages = true;
    } else {
      noMoreMessages = true;
    }
    Future.delayed(
      const Duration(milliseconds: 600),
      () {
        noMoreMessages = false;
        notifyListeners();
      },
    );
    nextPageLoading = false;
    notifyListeners();
  }
}

List<OnlyMessagesModel> onlyMessagesModelFromJson(String str) =>
    List<OnlyMessagesModel>.from(
        json.decode(str).map((x) => OnlyMessagesModel.fromJson(x)));

String onlyMessagesModelToJson(List<OnlyMessagesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnlyMessagesModel {
  OnlyMessagesModel({
    required this.id,
    required this.message,
    this.notify,
    this.attachment,
    this.type,
    this.supportTicketId,
  });

  dynamic id;
  String message;
  dynamic notify;
  String? attachment;
  dynamic type;
  dynamic supportTicketId;

  factory OnlyMessagesModel.fromJson(Map<String, dynamic> json) =>
      OnlyMessagesModel(
        id: json["id"],
        message: json["message"],
        notify: notifyValues.map[json["notify"]],
        attachment: json["attachment"],
        type: typeValues.map[json["type"]],
        supportTicketId: json["support_ticket_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "notify": notifyValues.reverse![notify],
        "attachment": attachment,
        "type": typeValues.reverse![type] ?? Type.MOBILE,
        "support_ticket_id": supportTicketId,
      };
}

enum Notify { ON, OFF }

final notifyValues = EnumValues({"off": Notify.OFF, "on": Notify.ON});

enum Type { MOBILE, ADMIN }

final typeValues = EnumValues({"admin": Type.ADMIN, "mobile": Type.MOBILE});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
