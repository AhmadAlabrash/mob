import 'package:flutter/material.dart';

class ExperienceSetupViewModel {
  TextEditingController titleController = TextEditingController();
  TextEditingController organizationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  ValueNotifier<DateTime?> startDate = ValueNotifier(null);
  ValueNotifier<DateTime?> endDate = ValueNotifier(null);

  ExperienceSetupViewModel._init();
  static ExperienceSetupViewModel? _instance;
  static ExperienceSetupViewModel get instance {
    _instance ??= ExperienceSetupViewModel._init();
    return _instance!;
  }

  ExperienceSetupViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }
}
