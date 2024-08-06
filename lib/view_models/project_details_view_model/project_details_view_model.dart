import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/services/project_details_service.dart';

import '../../models/packages_model.dart';

class ProjectDetailsViewModel {
  ValueNotifier<int> packageIndex = ValueNotifier(0);
  final List<Package> packages = [];

  String get selectedProject {
    switch (packageIndex.value) {
      case 1:
        return "Standard";
      case 2:
        return "Premium";
      default:
        return "Basic";
    }
  }

  initPackage(context, projectId) {
    packages.clear();
    debugPrint("project id is $projectId".toString());
    final pdProvider =
        Provider.of<ProjectDetailsService>(context, listen: false);
    debugPrint(
        "${pdProvider.projectPackages[projectId.toString()]}".toString());
    try {
      pdProvider.projectPackages[projectId.toString()]?.forEach((element) {
        debugPrint((element.name).toString());
        debugPrint((element.deliveryTime).toString());
        debugPrint((element.revision).toString());
        packages.add(element);
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    debugPrint("package length is ${packages.length}".toString());
  }

  ProjectDetailsViewModel._init();
  static ProjectDetailsViewModel? _instance;
  static ProjectDetailsViewModel get instance {
    _instance ??= ProjectDetailsViewModel._init();
    return _instance!;
  }

  ProjectDetailsViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }
}
