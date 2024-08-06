import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/models/packages_model.dart';
import 'package:xilancer/models/project_details_model.dart';

import '../data/network/network_api_services.dart';
import '../helper/app_urls.dart';
import '../helper/constant_helper.dart';
import '../helper/local_keys.g.dart';

class ProjectDetailsService with ChangeNotifier {
  final Map<String, ProjectDetailsModel> _projectDetailsModels = {};
  final Map<String, List<Package>> _projectPackages = {};
  Map<String, List<Package>> get projectPackages => _projectPackages;
  Map<String, ProjectDetailsModel> get projectDetailsModel =>
      _projectDetailsModels;

  String token = "";

  String projectFilePath = "";

  bool shouldAutoFetch(projectId) =>
      !_projectDetailsModels.containsKey(projectId.toString()) ||
      token.isInvalid;

  fetchOrderDetails({required projectId}) async {
    _projectDetailsModels.remove(projectId.toString());
    token = getToken;
    final url = "${AppUrls.projectDetailsUrl}/${projectId.toString()}";
    final responseData = await NetworkApiServices()
        .getApi(url, LocalKeys.projectDetails, headers: acceptJsonAuthHeader);

    try {
      if (responseData != null) {
        final tempData = ProjectDetailsModel.fromJson(responseData);
        _projectDetailsModels[projectId.toString()] = tempData;
        final tempProject = tempData.projectDetails;
        final List<Package> tempPackages = [];
        final basicPackage = Package(
            name: LocalKeys.basic,
            revision: tempProject?.basicRevision.toString().tryToParse ?? 0,
            deliveryTime: tempProject?.basicDelivery ?? "",
            regularPrice:
                tempProject?.basicRegularCharge.toString().tryToParse ?? 0,
            discountPrice: tempProject?.basicDiscountCharge,
            extraFields: []);
        tempProject?.projectAttributes?.forEach((element) {
          basicPackage.extraFields.add(ExtraField(
              id: element.id,
              name: element.checkNumericTitle ?? "",
              type: element.type.toString() == "checkbox"
                  ? FieldType.CHECK
                  : FieldType.QUANTITY,
              checked: element.basicCheckNumeric.toString() == "on",
              quantity: element.basicCheckNumeric.toString().tryToParse));
        });
        tempPackages.add(basicPackage);
        if (tempProject?.standardDelivery != null) {
          final standardPackage = Package(
              name: LocalKeys.standard,
              revision:
                  tempProject?.standardRevision.toString().tryToParse ?? 0,
              deliveryTime: tempProject?.standardDelivery ??
                  "".toString().tryToParse ??
                  0,
              regularPrice:
                  tempProject?.standardRegularCharge.toString().tryToParse ?? 0,
              discountPrice: tempProject?.standardDiscountCharge,
              extraFields: []);
          tempProject?.projectAttributes?.forEach((element) {
            standardPackage.extraFields.add(ExtraField(
                id: element.id,
                name: element.checkNumericTitle ?? "",
                type: element.type.toString() == "checkbox"
                    ? FieldType.CHECK
                    : FieldType.QUANTITY,
                checked: element.standardCheckNumeric.toString() == "on",
                quantity: element.standardCheckNumeric.toString().tryToParse));
          });
          tempPackages.add(standardPackage);
        }
        if (tempProject?.premiumDelivery != null) {
          final premiumPackage = Package(
              name: LocalKeys.premium,
              revision: tempProject?.premiumRevision.toString().tryToParse ?? 0,
              deliveryTime: tempProject?.premiumDelivery ?? "",
              regularPrice:
                  tempProject?.premiumRegularCharge.toString().tryToParse ?? 0,
              discountPrice: tempProject?.premiumDiscountCharge,
              extraFields: []);
          tempProject?.projectAttributes?.forEach((element) {
            premiumPackage.extraFields.add(ExtraField(
                id: element.id,
                name: element.checkNumericTitle ?? "",
                type: element.type.toString() == "checkbox"
                    ? FieldType.CHECK
                    : FieldType.QUANTITY,
                checked: element.premiumCheckNumeric.toString() == "on",
                quantity: element.premiumCheckNumeric.toString().tryToParse));
          });
          tempPackages.add(premiumPackage);
        }
        _projectPackages[projectId.toString()] = tempPackages;
        projectFilePath = (tempData.projectFilePath.toString());
      } else {}
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
    notifyListeners();
  }

  void setAlreadyApplied(projectId) {
    // _projectDetailsModels[projectId.toString()]?.alreadyApplied = true;
    notifyListeners();
  }

  void removeProject({required id}) {
    _projectDetailsModels.remove(id.toString());
    _projectPackages.remove(id.toString());
  }
}
