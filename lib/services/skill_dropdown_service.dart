import 'package:flutter/material.dart';
import '../../data/network/network_api_services.dart';
import '../../helper/app_urls.dart';
import '../../helper/constant_helper.dart';
import '../../helper/local_keys.g.dart';
import '../../models/skill_dropdown_model.dart';

class SkillDropdownService with ChangeNotifier {
  bool skillLoading = false;
  String skillSearchText = '';

  List<Skill> skillDropdownList = [];

  bool nextPageLoading = false;

  String? nextPage;

  bool nexLoadingFailed = false;

  setSkillSearchValue(value) {
    if (value == skillSearchText) {
      return;
    }
    skillSearchText = value;
    getSkill();
  }

  resetList() {
    if (skillSearchText.isEmpty && skillDropdownList.isNotEmpty) {
      return;
    }
    skillSearchText = '';
    skillDropdownList = [];
    getSkill();
  }

  void getSkill() async {
    skillLoading = true;
    nextPage = null;
    notifyListeners();
    final url = "${AppUrls.skillUrl}?skill=$skillSearchText";
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.skills, headers: commonAuthHeader);

    if (responseData != null) {
      final tempData = SkillDropdownModel.fromJson(responseData);
      skillDropdownList = tempData.allSkills?.skill ?? [];
      nextPage = tempData.allSkills?.nextPageUrl;
      debugPrint("Category dropdown list lenght is ${skillDropdownList.length}"
          .toString());
      notifyListeners();
    } else {}

    skillLoading = false;
    notifyListeners();
  }

  fetchNextPage() async {
    if (nextPageLoading || nextPage == null) return;
    nextPageLoading = true;
    notifyListeners();
    final responseData = await NetworkApiServices().getApi(
      nextPage!,
      LocalKeys.skills,
      headers: acceptJsonAuthHeader,
    );

    if (responseData != null) {
      final tempData = SkillDropdownModel.fromJson(responseData);
      tempData.allSkills?.skill?.forEach((element) {
        skillDropdownList.add(element);
      });

      nextPage = tempData.allSkills?.nextPageUrl;
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
