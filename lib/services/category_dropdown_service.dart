import 'package:flutter/material.dart';
import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/constant_helper.dart';
import '../../helper/local_keys.g.dart';
import '../../models/category_model.dart';

class CategoryDropdownService with ChangeNotifier {
  bool categoryLoading = false;
  String categorySearchText = '';

  List<Category?> categoryDropdownList = [];

  bool nextPageLoading = false;

  String? nextPage;

  bool nexLoadingFailed = false;

  setCategorySearchValue(value) {
    if (value == categorySearchText) {
      return;
    }
    categorySearchText = value;
  }

  resetList() {
    if (categorySearchText.isEmpty && categoryDropdownList.isNotEmpty) {
      return;
    }
    categorySearchText = '';
    categoryDropdownList = [];
    getCategory();
  }

  void getCategory() async {
    categoryLoading = true;
    nextPage = null;
    notifyListeners();
    final url = "${AppUrls.categoryUrl}?category=$categorySearchText";
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.category, headers: commonAuthHeader);

    if (responseData != null) {
      final tempData = CategoryModel.fromJson(responseData);
      categoryDropdownList = tempData.data ?? [];
      nextPage = tempData.links?.next;
      debugPrint(
          "Category dropdown list lenght is ${categoryDropdownList.length}"
              .toString());
      notifyListeners();
    } else {}

    categoryLoading = false;
    notifyListeners();
  }

  fetchNextPage() async {
    if (nextPageLoading || nextPage == null) return;
    nextPageLoading = true;
    final responseData =
        await NetworkApiServices().getApi(nextPage!, "Category fetching");

    if (responseData != null) {
      final tempData = CategoryModel.fromJson(responseData);
      tempData.data?.forEach((element) {
        categoryDropdownList.add(element);
      });

      nextPage = tempData.links?.next;
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
