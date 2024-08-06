import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/models/city_dropdown_model.dart';
import 'package:xilancer/models/state_model.dart';
import 'package:xilancer/services/profile_edit_service.dart';
import 'package:xilancer/services/profile_info_service.dart';

import '../../helper/local_keys.g.dart';
import '../../models/country_model.dart';

class ProfileEditViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();

  final ValueNotifier loading = ValueNotifier<bool>(false);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final ValueNotifier<Country?> selectedCountry = ValueNotifier(null);
  final ValueNotifier<States?> selectedState = ValueNotifier(null);
  final ValueNotifier<City?> selectedCity = ValueNotifier(null);
  ValueNotifier<String?> experienceLevel = ValueNotifier(null);
  ValueNotifier<File?> profileImage = ValueNotifier(null);

  List<String> experienceLevels = [
    LocalKeys.junior,
    LocalKeys.midLevel,
    LocalKeys.senior,
  ];

  ProfileEditViewModel._init();
  static ProfileEditViewModel? _instance;
  static ProfileEditViewModel get instance {
    _instance ??= ProfileEditViewModel._init();
    return _instance!;
  }

  static bool get dispose {
    _instance = null;
    return true;
  }

  void initEdit(BuildContext context) {
    final pi = Provider.of<ProfileInfoService>(context, listen: false)
        .profileInfoModel
        .data;
    firstNameController.text = pi?.firstName ?? "";
    lastNameController.text = pi?.lastName ?? "";
    emailController.text = pi?.email ?? "";
    phoneController.text = pi?.phone ?? "";
    experienceLevel.value = pi?.experienceLevel;

    if (pi?.countryId != null) {
      selectedCountry.value = Country(id: pi?.countryId, name: pi?.country);
    }
    if (pi?.stateId != null) {
      selectedState.value = States(id: pi?.stateId, name: pi?.state);
    }
    if (pi?.cityId != null) {
      selectedCity.value = City(id: pi?.cityId, name: pi?.city);
    }
    profileImage.value = null;
    loading.value = false;
  }

  setProfileImage() async {
    final file = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    if (file == null) {
      return;
    }
    // Check the file size
    final File imageFile = File(file.path);
    const int maxSize = 1024 * 1024; // 1MB
    final int fileSize = await imageFile.length();

    if (fileSize > maxSize) {
      // File size exceeds 1MB
      LocalKeys.imageMustBeLessThen1Mb.showToast();
      return;
    }

    debugPrint(file.name.toString());
    profileImage.value = File(file.path);
  }

  updateProfileInfo(BuildContext context) async {
    final validFrom = formKey.currentState?.validate() ?? false;
    if (!validFrom) {
      return;
    }
    if (!(countryValidate &&
        stateValidate &&
        cityValidate &&
        experienceValidate)) {
      return;
    }
    final peProvider = Provider.of<ProfileEditService>(context, listen: false);
    loading.value = true;
    peProvider
        .tryUpdatingProfile(
            context,
            firstNameController.text,
            lastNameController.text,
            emailController.text,
            phoneController.text,
            experienceLevel.value,
            selectedCountry.value?.id,
            selectedState.value?.id,
            selectedCity.value?.id,
            profileImage.value)
        .then((v) async {
      if (v == true) {
        await Provider.of<ProfileInfoService>(context, listen: false)
            .fetchProfileInfo();
        loading.value = false;
      } else {
        loading.value = false;
      }
    });
  }

  get countryValidate {
    if (selectedCountry.value?.id == null) {
      LocalKeys.selectACountry.showToast();
      return false;
    }
    return true;
  }

  get stateValidate {
    if (selectedState.value?.id == null) {
      LocalKeys.selectAState.showToast();
      return false;
    }
    return true;
  }

  get cityValidate {
    if (selectedCity.value?.id == null) {
      LocalKeys.selectACity.showToast();
      return false;
    }
    return true;
  }

  get experienceValidate {
    if (experienceLevel.value == null) {
      LocalKeys.selectExperience.showToast();
      return false;
    }
    return true;
  }
}
