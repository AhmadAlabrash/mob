import 'package:flutter/material.dart';
import 'package:xilancer/models/category_model.dart';
import 'package:xilancer/models/country_model.dart';
import 'package:xilancer/views/home_drawer_view/components/filter_experience_level.dart';

import '../../helper/constant_helper.dart';
import '../../helper/extension/string_extension.dart';
import '../../helper/local_keys.g.dart';
import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';
import '../models/job_list_model.dart';

class JobListService with ChangeNotifier {
  JobListModel? _jobListModel;

  var projectLength;
  JobListModel get jobListModel => _jobListModel ?? JobListModel();
  List<Job>? jobList;
  var token = "";
  bool isLoading = false;

  Category? category;
  SubCategory? subCat;
  Country? country;
  ExperienceLav? experience;
  String? length;
  String? maxPrice;
  String? minPrice;
  String searchText = "";
  double rating = 0.0;

  setFilters(
    Country? country,
    ExperienceLav? experience,
    String? length,
    String? maxPrice,
    String? minPrice,
    Category? category,
    SubCategory? subCat,
    double rating,
  ) {
    if (this.country == country &&
        this.experience == experience &&
        this.length == length &&
        this.category == category &&
        this.subCat == subCat &&
        this.maxPrice == maxPrice &&
        this.minPrice == minPrice) {
      return;
    }
    this.country = country;
    this.experience = experience;
    this.length = length;
    this.maxPrice = maxPrice;
    this.minPrice = minPrice;
    this.category = category;
    this.subCat = subCat;
    this.rating = rating;
    fetchJobList();
  }

  // Map get requestBody {
  //   var body = {
  //     'type': 'fixed',
  //     "string": searchText,
  //   };
  //   if (category != null) {
  //     body.putIfAbsent("category", () => category?.id.toString() ?? "");
  //   }
  //   if (category != null) {
  //     body.putIfAbsent("subCategory", () => subCat?.id.toString() ?? "");
  //   }
  //   if (category != null) {
  //     body.putIfAbsent("country", () => country?.id.toString() ?? "");
  //   }
  //   if (experience != null && experience != ExperienceLav.ANY) {
  //     body.putIfAbsent(
  //         "level",
  //         () => expLabel(experience ?? ExperienceLav.ANY, translate: false)
  //             .toLowerCase()
  //             .replaceAll(" level", "")
  //             .replaceAll(" ", ""));
  //   }
  //   if (category != null) {
  //     body.putIfAbsent("duration", () => length?.toLowerCase() ?? "");
  //   }
  //   if (minPrice != null) {
  //     body.putIfAbsent("min_price", () => minPrice ?? "");
  //   }
  //   if (maxPrice != null) {
  //     body.putIfAbsent("max_price", () => maxPrice ?? "");
  //   }
  //   return body;
  // }

  var nextPage;

  bool nextPageLoading = false;

  bool nexLoadingFailed = false;

  bool get shouldAutoFetch => jobList == null || token.isInvalid;

  fetchJobList({refreshing = false}) async {
    token = getToken;
    final url = AppUrls.jobListUrl;
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.jobList, headers: acceptJsonAuthHeader);

    try {
      if (responseData != null) {
        _jobListModel = JobListModel.fromJson(responseData);
        jobList = jobListModel.jobs?.job ?? [];
        nextPage = jobListModel.jobs?.nextPageUrl;
      } else {
        jobList ??= [];
      }
    } catch (e) {
      e.toString().showToast();
    }
    notifyListeners();
  }

  fetchNextPage() async {
    token = getToken;
    if (nextPageLoading) return;
    nextPageLoading = true;
    notifyListeners();
    final responseData = await NetworkApiServices()
        .getApi(nextPage, LocalKeys.jobList, headers: commonAuthHeader);

    if (responseData != null) {
      final tempData = JobListModel.fromJson(responseData);
      tempData.jobs?.job?.forEach((element) {
        jobList?.add(element);
      });
      nextPage = tempData.jobs?.nextPageUrl;
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

  void resetFilters() {
    country = null;
    experience = null;
    length = null;
    maxPrice = null;
    minPrice = null;
    category = null;
    subCat = null;
    rating = 0.0;
    fetchJobList();
  }

  void setSearchText(String value) {
    searchText = value;
  }

  void changeJobStatus(id, jobStatus) {
    jobList
        ?.firstWhere((element) => element.id.toString() == id.toString())
        .onOff = jobStatus == true ? 0 : 1;
    notifyListeners();
  }
}
