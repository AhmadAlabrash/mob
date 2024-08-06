import 'package:flutter/material.dart';
import 'package:xilancer/helper/local_keys.g.dart';

class ProfileDetailsViewModel {
  final viewAsClient = ValueNotifier(true);
  final editPrice = ValueNotifier(false);
  TextEditingController priceController = TextEditingController();
  TextEditingController skillTextController = TextEditingController();
  ScrollController controller = ScrollController();
  ValueNotifier skillEditing = ValueNotifier(false);
  ProfileDetailsViewModel._init();
  static ProfileDetailsViewModel? _instance;
  static ProfileDetailsViewModel get instance {
    _instance ??= ProfileDetailsViewModel._init();
    return _instance!;
  }

  ProfileDetailsViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }
}
