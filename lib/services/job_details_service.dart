import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:http/http.dart' as http;

import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';
import '../helper/constant_helper.dart';
import '../helper/local_keys.g.dart';
import '../models/job_details_model.dart';

class JobDetailsService with ChangeNotifier {
  JobDetailsModel? _jobDetailsModel;
  JobDetailsModel get jobDetailsModel => _jobDetailsModel ?? JobDetailsModel();

  String token = "";
  String id = "";

  bool shouldAutoFetch(id) =>
      this.id.toString() != id.toString() || token.isInvalid;

  num get shortListCount {
    try {
      return jobDetailsModel.jobDetails?.jobProposals
              ?.where((element) => element.isShortListed.toString() == "1")
              .length ??
          0;
    } catch (e) {
      return 0;
    }
  }

  num get hiredCount {
    try {
      return jobDetailsModel.jobDetails?.jobProposals
              ?.where((element) => element.isHired.toString() == "1")
              .length ??
          0;
    } catch (e) {
      return 0;
    }
  }

  num get interviewedCount {
    try {
      return jobDetailsModel.jobDetails?.jobProposals
              ?.where((element) => element.isInterviewTake.toString() == "1")
              .length ??
          0;
    } catch (e) {
      return 0;
    }
  }

  // bool get shouldAutoFetch => _jobDetailsModel == null || token.isInvalid;

  fetchDetails({required jobId}) async {
    _jobDetailsModel = null;
    id = jobId.toString();
    token = getToken;
    final url = "${AppUrls.jobDetailsUrl}/${jobId.toString()}";
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.jobDetails, headers: acceptJsonAuthHeader);

    if (responseData != null) {
      _jobDetailsModel = JobDetailsModel.fromJson(responseData);
    } else {}
    notifyListeners();
  }

  tryClosingJob(
    jobId,
    status,
  ) async {
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $getToken'
    };
    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrls.jobStatusToggleUrl));
    request.fields.addAll({
      'job_id': jobId,
    });

    request.headers.addAll(headers);
    final responseData = await NetworkApiServices()
        .postWithFileApi(request, LocalKeys.sendOffer);
    if (responseData != null) {
      status == true
          ? LocalKeys.jobClosedSuccessfully.showToast()
          : LocalKeys.jobOpenedSuccessfully.showToast();
      try {
        if (jobDetailsModel.jobDetails?.id.toString() == id.toString()) {
          jobDetailsModel.jobDetails?.onOff = status == true ? 0 : 1;
        }
      } catch (e) {}
      return true;
    } else {}
  }

  List<JobProposal> proposalList(int tabIndex) {
    switch (tabIndex) {
      case 1:
        return jobDetailsModel.jobDetails?.jobProposals
                ?.where((element) => element.isHired.toString() == "1")
                .toList() ??
            [];
      case 2:
        return jobDetailsModel.jobDetails?.jobProposals
                ?.where((element) => element.isShortListed.toString() == "1")
                .toList() ??
            [];
      case 3:
        return jobDetailsModel.jobDetails?.jobProposals
                ?.where((element) => element.isInterviewTake.toString() == "1")
                .toList() ??
            [];

      default:
        return jobDetailsModel.jobDetails?.jobProposals ?? [];
    }
  }

  tryRejectingProposal({id}) async {
    var url = AppUrls.proposalRejectUrl;
    var data = {"proposal_id": id.toString()};

    final responseData = await NetworkApiServices().postApi(
      data,
      url,
      LocalKeys.reject,
      headers: acceptJsonAuthHeader,
    );

    if (responseData != null) {
      LocalKeys.proposalRejectedSuccessfully.showToast();
      _jobDetailsModel?.jobDetails?.jobProposals
          ?.firstWhere((element) => element.id.toString() == id.toString())
          .isRejected = 1;
      notifyListeners();
      return true;
    }
  }

  // tryAcceptingProposal({id}) async {
  //   var url = AppUrls.editJobUrl;
  //   var data = {};

  //   final responseData = await NetworkApiServices().postApi(
  //     data,
  //     url,
  //     LocalKeys.reject,
  //     headers: acceptJsonAuthHeader,
  //   );

  //   if (responseData != null) {
  //     LocalKeys.proposalAcceptedSuccessfully.showToast();
  //     _jobDetailsModel?.jobDetails?.jobProposals
  //         ?.firstWhere((element) => element.id.toString() == id.toString())
  //         .isHired = 1;
  //     return true;
  //   }
  // }

  tryAddingToShortlist({id, shortlisted}) async {
    var url = AppUrls.shortlistToggleUrl;
    var data = {
      "proposal_id": id.toString(),
    };

    final responseData = await NetworkApiServices().postApi(
      data,
      url,
      LocalKeys.shortListed,
      headers: acceptJsonAuthHeader,
    );

    if (responseData != null) {
      shortlisted
          ? LocalKeys.removedFromShortListSuccessfully.showToast()
          : LocalKeys.addedToShortlistSuccessfully.showToast();
      try {
        _jobDetailsModel?.jobDetails?.jobProposals
            ?.firstWhere((element) => element.id.toString() == id.toString())
            .isShortListed = shortlisted ? 0 : 1;
      } catch (e) {
        debugPrint(e.toString());
      }
      notifyListeners();
      return true;
    }
  }

  void reset() {
    _jobDetailsModel = null;
    id = "";
  }
}
