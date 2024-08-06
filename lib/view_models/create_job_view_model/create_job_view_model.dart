import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/main.dart';
import 'package:xilancer/services/create_job_service.dart';
import 'package:xilancer/services/job_details_service.dart';
import 'package:xilancer/utils/components/alerts.dart';

import '../../models/category_model.dart';
import '../../models/skill_dropdown_model.dart';

class CreateJobViewModel {
  ValueNotifier currentIndex = ValueNotifier(0);
  TextEditingController skillController = TextEditingController();
  ValueNotifier<File?> profilePicture = ValueNotifier(null);
  ValueNotifier<File?> selectedAttachment = ValueNotifier(null);
  ValueNotifier<Category?> selectedCategory = ValueNotifier(null);
  ValueNotifier<List<SubCategory>> selectedSubcategories = ValueNotifier([]);
  ValueNotifier multiplePackages = ValueNotifier(false);
  ValueNotifier isLoading = ValueNotifier(false);

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController slugController = TextEditingController();
  dynamic jobId;

  bool editing = false;

  // ValueNotifier<List<Package>> packages =
  //     ValueNotifier([defaultPackage, defaultPackage, defaultPackage]);
  List timelineList = [
    LocalKeys.jobIntro,
    LocalKeys.budgetsAndSkills,
  ];
  List timelineDescriptions = [
    LocalKeys.jobIntroDesc,
    LocalKeys.jobGalleryUploadDesc,
  ];

  ValueNotifier<List<double>> heights = ValueNotifier([
    0.0,
    0.0,
    0.0,
  ]);

  final GlobalKey<FormState> introFormKey = GlobalKey();
  final GlobalKey<FormState> sbFormKey = GlobalKey();

  PageController pageController = PageController(initialPage: 0);

  ValueNotifier<List<Skill>> skillList = ValueNotifier([]);

  ValueNotifier packageEditingIndex = ValueNotifier(0);

  ValueNotifier<String?> selectedLengths = ValueNotifier(null);
  ValueNotifier<String?> selectedExperienceLevel = ValueNotifier(null);

  CreateJobViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  CreateJobViewModel._init();
  static CreateJobViewModel? _instance;
  static CreateJobViewModel get instance {
    _instance ??= CreateJobViewModel._init();
    return _instance!;
  }

  get introValidator {
    final valid = introFormKey.currentState?.validate();
    if (valid != true) {
      return valid;
    }
    if (selectedCategory.value == null) {
      LocalKeys.selectCategory.showToast();
      return false;
    }
    if (selectedSubcategories.value.isEmpty) {
      LocalKeys.selectSubcategory.showToast();
      return false;
    }
    if (selectedSubcategories.value.isEmpty) {
      LocalKeys.selectSubcategory.showToast();
      return false;
    }
    if (selectedLengths.value == null) {
      LocalKeys.selectJobDuration.showToast();
      return false;
    }
    if (selectedExperienceLevel.value == null) {
      LocalKeys.selectExperience.showToast();
      return false;
    }
  }

  get skillBudgetValidator {
    final valid = sbFormKey.currentState?.validate();
    if (valid != true) {
      return valid;
    }
    if (skillList.value.isEmpty) {
      LocalKeys.addASkill.showToast();
      return false;
    }
    if (skillList.value.isEmpty) {
      LocalKeys.addASkill.showToast();
      return false;
    }
  }

  void nextPage(BuildContext context) async {
    debugPrint(pageController.page.toString());
    switch (pageController.page) {
      case 0.0:
        if (introValidator == false) {
          return;
        }
        await pageController.nextPage(
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        currentIndex.value = pageController.page;
        break;
      default:
        if (skillBudgetValidator == false) {
          return;
        }
        final cjProvider =
            Provider.of<CreateJobService>(context, listen: false);
        isLoading.value = true;
        if (jobId == null) {
          await cjProvider.tryCreatingJob().then((v) {
            if (v == true) {
              context.popTrue;
            }
          });
        } else {
          await cjProvider.tryEditingJob().then((v) {
            if (v == true) {
              Provider.of<JobDetailsService>(context, listen: false).reset();
              context.popTrue;
            }
          });
        }
        isLoading.value = false;
    }
  }

  void goBack(BuildContext context) async {
    if (pageController.page == 0.0) {
      await Alerts().confirmationAlert(
        context: context,
        title: LocalKeys.areYouSure,
        description: LocalKeys.youChangesWillBeLost,
        onConfirm: () async {
          context.pop;
          context.pop;
          // context.pop;
        },
      );

      return;
    }
    await pageController.previousPage(
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
    currentIndex.value = pageController.page;
  }

  void selectFile() async {
    try {
      PickedFile? file = await ImagePicker.platform.pickImage(
          source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);
      if (file == null) {
        return;
      }
      profilePicture.value = File(file.path);
      LocalKeys.fileSelected.showToast();
    } catch (error) {
      LocalKeys.fileSelectFailed.showToast();
    }
  }

  void setSelectedSectionIndex(value) {
    currentIndex.value = value;
    currentIndex.notifyListeners();
  }

  void setJob(BuildContext context) {
    final jd = Provider.of<JobDetailsService>(context, listen: false);
    titleController.text = jd.jobDetailsModel.jobDetails?.title ?? "";
    descriptionController.text =
        jd.jobDetailsModel.jobDetails?.description ?? "";
    priceController.text =
        jd.jobDetailsModel.jobDetails?.budget?.toString() ?? "";
    slugController.text = jd.jobDetailsModel.jobDetails?.slug ?? "";
    selectedCategory.value = Category(
        id: jd.jobDetailsModel.jobDetails?.category,
        name: jd.jobDetailsModel.jobDetails?.jobCategory?.category);
    selectedExperienceLevel.value = jd.jobDetailsModel.jobDetails?.level ?? "";
    jd.jobDetailsModel.jobDetails?.jobSubCategories?.forEach((element) {
      try {
        selectedSubcategories.value
            .firstWhere((e) => e.id.toString() == element.id.toString());
      } catch (e) {
        selectedSubcategories.value
            .add(SubCategory(id: element.id, subCategory: element.subCategory));
      }
    });
    jd.jobDetailsModel.jobDetails?.jobSkills?.forEach((element) {
      try {
        skillList.value
            .firstWhere((e) => e.id.toString() == element.id.toString());
      } catch (e) {
        skillList.value.add(Skill(id: element.id, skill: element.skill));
      }
    });
    selectedLengths.value = jd.jobDetailsModel.jobDetails?.duration;
    jobId = jd.jobDetailsModel.jobDetails?.id;
    editing = true;
  }
}
