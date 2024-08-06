import 'package:flutter/material.dart';
import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/constant_helper.dart';
import '../../helper/local_keys.g.dart';
import '../../models/city_dropdown_model.dart';
import '../../models/country_model.dart';

class CityDropdownService with ChangeNotifier {
  bool cityLoading = false;
  String citySearchText = '';
  var stateId;

  List<City> cityList = [];

  bool nextPageLoading = false;

  String? nextPage;

  bool nexLoadingFailed = false;

  setCitySearchValue(value) {
    if (value == citySearchText) {
      return;
    }
    citySearchText = value;
  }

  resetList(sId) {
    if (citySearchText.isEmpty && cityList.isNotEmpty && sId == stateId) {
      return;
    }
    citySearchText = '';
    cityList = [];
    stateId = sId;
    getCity();
  }

  void getCity() async {
    cityLoading = true;
    nextPage = null;
    notifyListeners();
    final url =
        "${AppUrls.cityUrl}?state_id=$stateId${citySearchText.isEmpty ? "" : '&city=$citySearchText'}";
    final responseData = await NetworkApiServices()
        .postApi({}, url, LocalKeys.city, headers: commonAuthHeader);

    if (responseData != null) {
      cityList = CityDropdownModel.fromJson(responseData).cities ?? [];
      notifyListeners();
    } else {}

    cityLoading = false;
    notifyListeners();
  }

  fetchNextPage() async {
    if (nextPageLoading || nextPage == null) return;
    nextPageLoading = true;
    debugPrint("fetching dashboard info".toString());
    final responseData =
        await NetworkApiServices().getApi(nextPage!, "Country fetching");

    if (responseData != null) {
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
