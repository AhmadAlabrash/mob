import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:http/http.dart' as http;
import 'package:xilancer/helper/app_urls.dart';
import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';

import '../data/network/network_api_services.dart';

class CreateJobService with ChangeNotifier {
  tryCreatingJob() async {
    final cjm = CreateJobViewModel.instance;

    var request =
        http.MultipartRequest('POST', Uri.parse(AppUrls.createJobUrl));
    request.fields.addAll({
      'title': cjm.titleController.text,
      'slug': cjm.titleController.text,
      'category': cjm.selectedCategory.value?.id.toString() ?? "",
      'duration': cjm.selectedLengths.value ?? "",
      'level': cjm.selectedExperienceLevel.value ?? "",
      'description': cjm.descriptionController.text,
      'type': 'fixed',
      'budget': cjm.priceController.text.tryToParse.toString(),
      'skill': jsonEncode(
          cjm.skillList.value.map((e) => {"skill_id": e.id}).toList()),
      'subcategory': jsonEncode(cjm.selectedSubcategories.value
          .map((e) => {"sub_category_id": e.id})
          .toList())
    });
    if (cjm.selectedAttachment.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'attachment', cjm.selectedAttachment.value!.path));
    }
    request.headers.addAll(acceptJsonAuthHeader);

    final responseData = await NetworkApiServices()
        .postWithFileApi(request, LocalKeys.createJob);

    if (responseData != null) {
      LocalKeys.jobCreatedSuccessfully.showToast();

      return true;
    }
  }

  tryEditingJob() async {
    final cjm = CreateJobViewModel.instance;

    var request = http.MultipartRequest('POST', Uri.parse(AppUrls.editJobUrl));
    request.fields.addAll({
      "job_id": cjm.jobId.toString(),
      'title': cjm.titleController.text,
      'slug': cjm.slugController.text,
      'category': cjm.selectedCategory.value?.id.toString() ?? "",
      'duration': cjm.selectedLengths.value ?? "",
      'level': cjm.selectedExperienceLevel.value ?? "",
      'description': cjm.descriptionController.text,
      'type': 'fixed',
      'budget': cjm.priceController.text.tryToParse.toString(),
      'skill': jsonEncode(
          cjm.skillList.value.map((e) => {"skill_id": e.id}).toList()),
      'subcategory': jsonEncode(cjm.selectedSubcategories.value
          .map((e) => {"sub_category_id": e.id})
          .toList())
    });
    if (cjm.selectedAttachment.value?.path != null) {
      request.files.add(await http.MultipartFile.fromPath(
          'attachment', cjm.selectedAttachment.value!.path));
    }
    request.headers.addAll(acceptJsonAuthHeader);

    final responseData = await NetworkApiServices()
        .postWithFileApi(request, LocalKeys.createJob);

    if (responseData != null) {
      LocalKeys.jobEditedSuccessfully.showToast();
      return true;
    }
  }
}
