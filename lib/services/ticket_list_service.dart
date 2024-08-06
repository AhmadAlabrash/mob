import 'package:flutter/material.dart';
import '../../helper/extension/string_extension.dart';
import '../../helper/extension/widget_extension.dart';
import '../../helper/local_keys.g.dart';
import '../../models/ticket_list_model.dart';

import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';
import '../helper/constant_helper.dart';

class TicketListService with ChangeNotifier {
  var priorityList = ["high", "urgent", "normal"];
  List<Department>? departments;
  List<Datum> ticketList = [];

  Map<String, Color> priorityColor = {
    'low': const Color(0xff6BB17B),
    'medium': const Color(0xff70B9AE),
    'high': const Color(0xffBFB55A),
    'urgent': const Color(0xffC66060),
  };

  var token = "";

  var nextPage;
  bool nextPageLoading = false;

  bool nexLoadingFailed = false;

  bool get shouldAutoFetch => ticketList.isEmpty || token.isInvalid;
  bool get shouldAutoFetchDepartments => departments == null;

  fetchTicketList() async {
    token = getToken;
    final responseData = await NetworkApiServices().getApi(
        AppUrls.ticketListUrl, LocalKeys.supportTicket,
        headers: commonAuthHeader);

    if (responseData != null) {
      final ticketData = TicketListModel.fromJson(responseData);
      ticketList = ticketData.data;
      nextPage = ticketData.nextPageUrl;
    } else {}
    notifyListeners();
  }

  fetchNextPage() async {
    token = getToken;
    if (nextPageLoading) return;
    nextPageLoading = true;
    notifyListeners();
    final responseData = await NetworkApiServices()
        .getApi(nextPage, LocalKeys.supportTicket, headers: commonAuthHeader);

    if (responseData != null) {
      final ticketData = TicketListModel.fromJson(responseData);
      for (var element in ticketData.data) {
        ticketList.add(element);
      }
      nextPage = ticketData.nextPageUrl;
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

  fetchDepartments() async {
    if (departments != null) {
      debugPrint(departments?.map((e) => e.name).toList().toString());
      return;
    }
    final responseData = await NetworkApiServices().getApi(
        AppUrls.stDepartmentsUrl, LocalKeys.department,
        headers: commonAuthHeader);

    if (responseData != null) {
      departments = DepartmentModel.fromJson(responseData).data;
    } else {
      departments = [];
      Future.delayed(const Duration(seconds: 1)).then((value) {
        departments = null;
      });
    }
    notifyListeners();
  }
}
