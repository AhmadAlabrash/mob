import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/models/category_model.dart';
import 'package:xilancer/services/job_list_service.dart.dart';
import 'package:xilancer/services/project_list_service.dart.dart';

import '../../models/city_dropdown_model.dart';
import '../../models/country_model.dart';
import '../../models/state_model.dart';
import '../../views/home_drawer_view/components/filter_experience_level.dart';
import '../../views/home_drawer_view/components/filter_job_type.dart';

class HomeDrawerViewModel {
  double rating = 3;

  TextEditingController searchController = TextEditingController();

  ValueNotifier<bool> isLoading = ValueNotifier(false);

  ValueNotifier<RangeValues> rangeValue =
      ValueNotifier(const RangeValues(0, 50));
  ValueNotifier selectedExp = ValueNotifier(ExperienceLav.ANY);
  ValueNotifier selectedJT = ValueNotifier(JobTypes.ANY);
  ValueNotifier<String?> selectedLengths = ValueNotifier(null);
  TextEditingController maxPriceController = TextEditingController();
  TextEditingController minPriceController = TextEditingController();

  final ValueNotifier<Country?> selectedCountry = ValueNotifier(null);
  final ValueNotifier<States?> selectedState = ValueNotifier(null);
  final ValueNotifier<City?> selectedCity = ValueNotifier(null);

  final ValueNotifier<Category?> selectedCategory = ValueNotifier(null);
  final ValueNotifier<SubCategory?> selectedSubCat = ValueNotifier(null);

  final ValueNotifier<double?> ratings = ValueNotifier(null);

  HomeDrawerViewModel._init();
  static HomeDrawerViewModel? _instance;
  static HomeDrawerViewModel get instance {
    _instance ??= HomeDrawerViewModel._init();
    return _instance!;
  }

  HomeDrawerViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  setFilters(BuildContext context) async {
    final jl = Provider.of<ProjectListService>(context, listen: false);
    jl.setFilters(
        selectedCountry.value,
        selectedExp.value,
        selectedLengths.value,
        maxPriceController.text,
        minPriceController.text,
        selectedCategory.value,
        selectedSubCat.value,
        ratings.value);
  }

  resetFilters(BuildContext context) async {
    final jl = Provider.of<ProjectListService>(context, listen: false);
    jl.resetFilters();
  }

  setValues(
    Country? country,
    ExperienceLav? experience,
    String? length,
    String? maxPrice,
    String? minPrice,
    Category? category,
    SubCategory? subCat,
    double? rating,
  ) {
    selectedCategory.value = category;
    selectedSubCat.value = subCat;
    selectedCountry.value = country;
    selectedLengths.value = length;
    selectedExp.value = experience;
    maxPriceController.text = maxPrice ?? "";
    minPriceController.text = minPrice ?? "";
    ratings.value = rating;
  }
}
