import 'dart:io';

import 'package:flutter/material.dart';

class ProfileEditViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  final ValueNotifier<File?> idCard = ValueNotifier(null);
  final ValueNotifier<File?> idDrivingCard = ValueNotifier(null);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController idNumberController = TextEditingController();

  ProfileEditViewModel._init();
  static ProfileEditViewModel? _instance;
  static ProfileEditViewModel get instance {
    _instance ??= ProfileEditViewModel._init();
    return _instance!;
  }

  ProfileEditViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }
}
