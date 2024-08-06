import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/models/ticket_list_model.dart';
import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/local_keys.g.dart';

import '../helper/constant_helper.dart';

class SupportTicketCreateService with ChangeNotifier {
  createTicket(
      {title,
      subject,
      priority,
      description,
      required Department selectedDepartment}) async {
    final body = {
      'title': title,
      'subject': subject,
      'priority': priority,
      'description': description,
      'department': selectedDepartment.id.toString()
    };

    final responseData = await NetworkApiServices().postApi(
        body, AppUrls.createTicketUrl, LocalKeys.createTicket,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      LocalKeys.ticketCreatedSuccessfully.showToast();
      return true;
    }
  }
}
