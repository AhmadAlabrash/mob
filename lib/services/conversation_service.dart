import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';

import '../data/network/network_api_services.dart';
import '../models/conversation_model.dart';

class ConversationService with ChangeNotifier {
  ConversationModel? _conversationModel;
  ConversationModel get conversationModel =>
      _conversationModel ?? ConversationModel();

  var token = "";

  var nextPage;

  bool nextPageLoading = false;

  bool nexLoadingFailed = false;

  bool get shouldAutoFetch => _conversationModel == null || token.isInvalid;

  fetchConversationMessages(conversationId) async {
    token = getToken;
    _conversationModel = null;
    var url = "${AppUrls.conversationUrl}/$conversationId";

    final responseData = await NetworkApiServices()
        .getApi(url, null, headers: acceptJsonAuthHeader);

    if (responseData != null) {
      final tempData = ConversationModel.fromJson(responseData);
      _conversationModel = tempData;
      nextPage = tempData.allMessage?.nextPageUrl;
      notifyListeners();
      return true;
    }
  }

  trySendingMessage(message, File? file, freelancerId) async {
    final url = AppUrls.messageSendUrl;
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll(
        {'freelancer_id': freelancerId.toString(), 'message': message ?? ""});
    debugPrint({
      'freelancer_id': freelancerId.toString(),
      'message': message ?? ""
    }.toString());
    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath("file", file.path,
          filename: basename(file.path)));
    }
    request.headers.addAll(acceptJsonAuthHeader);

    final responseData = await NetworkApiServices()
        .postWithFileApi(request, LocalKeys.sendMessage);

    if (responseData != null) {
      _conversationModel?.allMessage?.data?.insert(
          0,
          Datum(
            fromUser: "1",
            message: Message(message: message.isEmpty ? null : message),
            file: file,
          ));
      try {
        AssetsAudioPlayer.newPlayer().open(
          Audio("assets/audios/chat1.mp3"),
          autoStart: true,
          showNotification: false,
        );
      } catch (e) {}
      notifyListeners();
      return true;
    }
  }

  void addNewMessage(messageReceived) {
    debugPrint("trying to add new message".toString());
    try {
      AssetsAudioPlayer.newPlayer().open(
        Audio("assets/audios/chat.mp3"),
        autoStart: true,
        showNotification: false,
      );
    } catch (e) {}
    _conversationModel?.allMessage?.data
        ?.insert(0, Datum.fromJson(messageReceived));
    notifyListeners();
  }

  void fetchNextPage() async {
    token = getToken;
    if (nextPageLoading) return;
    nextPageLoading = true;
    notifyListeners();
    final responseData = await NetworkApiServices()
        .getApi(nextPage, LocalKeys.jobList, headers: commonAuthHeader);

    if (responseData != null) {
      final tempData = ConversationModel.fromJson(responseData);
      tempData.allMessage?.data?.forEach((element) {
        _conversationModel?.allMessage?.data?.add(element);
      });
      nextPage = tempData.allMessage?.nextPageUrl;
    } else {
      nexLoadingFailed = true;
      Future.delayed(const Duration(seconds: 1)).then((value) {
        nexLoadingFailed = false;
        notifyListeners();
      });
    }
    nextPageLoading = false;
    notifyListeners();
  }
}
