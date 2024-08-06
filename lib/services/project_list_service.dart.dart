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
import '../models/project_list_model.dart';
import '../view_models/home_drawer_view_model/home_drawer_view_model.dart';

class ProjectListService with ChangeNotifier {
  ProjectListModel? _projectListModel;
  ProjectListModel get projectListModel =>
      _projectListModel ?? ProjectListModel();
  List<Project>? projectList;
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
  double? rating;

  setFilters(
    Country? country,
    ExperienceLav? experience,
    String? length,
    String? maxPrice,
    String? minPrice,
    Category? category,
    SubCategory? subCat,
    double? rating,
  ) {
    if (this.country == country &&
        this.experience == experience &&
        this.length == length &&
        this.category == category &&
        this.subCat == subCat &&
        this.maxPrice == maxPrice &&
        this.minPrice == minPrice &&
        this.rating == rating) {
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
    fetchProjectList(refreshing: false);
  }

  Map get requestBody {
    var body = {
      // 'type': 'fixed',
      "string": searchText,
    };
    if (category != null) {
      body.putIfAbsent("category", () => category?.id.toString() ?? "");
    }
    if (category != null && subCat != null) {
      body.putIfAbsent("subCategory", () => subCat?.id.toString() ?? "");
    }
    if (country != null) {
      body.putIfAbsent("country", () => country?.id.toString() ?? "");
    }
    if (experience != null && experience != ExperienceLav.ANY) {
      body.putIfAbsent(
          "level",
          () => expLabel(experience ?? ExperienceLav.ANY, translate: false)
              .toLowerCase()
              .replaceAll(" level", "")
              .replaceAll(" ", ""));
    }
    debugPrint(length.toString());
    if (length != null) {
      debugPrint(length.toString());
      body.putIfAbsent("duration", () => length?.toLowerCase() ?? "");
    }
    if (minPrice != null) {
      body.putIfAbsent("min_price", () => minPrice ?? "");
    }
    if (maxPrice != null) {
      body.putIfAbsent("max_price", () => maxPrice ?? "");
    }
    if (rating != null) {
      body.putIfAbsent("rating", () => rating?.toString() ?? "");
    }
    debugPrint(body.toString());
    return body;
  }

  var nextPage;

  bool nextPageLoading = false;

  bool nexLoadingFailed = false;

  bool get shouldAutoFetch => projectList == null || token.isInvalid;

  fetchProjectList({refreshing = false}) async {
    debugPrint("trying to fetch job list".toString());
    token = getToken;
    final hdm = HomeDrawerViewModel.instance;
    if (refreshing == false) {
      debugPrint("not refreshing".toString());
      hdm.isLoading.value = true;
      // notifyListeners();
    }
    debugPrint("fetching dashboard info".toString());
    final url = AppUrls.projectFilterUrl;
    final responseData = await NetworkApiServices().postApi(
        requestBody, url, LocalKeys.projectList,
        headers: acceptJsonAuthHeader);

    if (responseData != null) {
      _projectListModel = ProjectListModel.fromJson(responseData);
      projectList = projectListModel.projects?.projects ?? [];
      nextPage = projectListModel.projects?.nextPageUrl;
    } else {
      projectList ??= [];
    }
    hdm.isLoading.value = false;
    notifyListeners();
  }

  fetchNextPage() async {
    token = getToken;
    if (nextPageLoading) return;
    nextPageLoading = true;
    notifyListeners();
    final responseData = await NetworkApiServices().postApi(
        requestBody, nextPage, LocalKeys.projectList,
        headers: commonAuthHeader);

    if (responseData != null) {
      final tempData = ProjectListModel.fromJson(responseData);
      tempData.projects?.projects?.forEach((element) {
        projectList?.add(element);
      });
      nextPage = tempData.projects?.nextPageUrl;
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
    rating = null;
    fetchProjectList();
  }

  void setSearchText(String value) {
    searchText = value;
  }
}
