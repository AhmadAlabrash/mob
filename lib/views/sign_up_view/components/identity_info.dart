import 'package:flutter/material.dart';

import '../../../view_models/sign_up_view/sign_up_view_model.dart';
import '/helper/local_keys.g.dart';
import '/helper/svg_assets.dart';
import '/utils/components/custom_dropdown.dart';
import '/utils/components/field_label.dart';
import '/utils/components/field_with_label.dart';
import '../../../utils/components/empty_spacer_helper.dart';
import 'driving_license_card_select.dart';
import 'id_card_select.dart';

class IdentityInfo extends StatelessWidget {
  const IdentityInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final suv = SignUpViewModel.instance;
    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(label: LocalKeys.identityType),
        CustomDropdown(
          LocalKeys.selectIdentityType,
          const ['s'],
          (value) {},
          svgIcon: SvgAssets.card,
        ),
        EmptySpaceHelper.emptyHeight(16),
        FieldWithLabel(
          label: LocalKeys.identityNumber,
          hintText: LocalKeys.enterIdentityNumber,
          svgPrefix: SvgAssets.card,
        ),
        IdCardSelect(suv: suv),
        FieldLabel(label: LocalKeys.vehicleType),
        CustomDropdown(
          LocalKeys.selectVehicleType,
          const ['s'],
          (value) {},
        ),
        EmptySpaceHelper.emptyHeight(16),
        FieldWithLabel(
          label: LocalKeys.identityNumber,
          hintText: LocalKeys.enterDrivingLicenseNumber,
          svgPrefix: SvgAssets.card,
        ),
        DrivingLicenseCardSelect(suv: suv),
      ],
    ));
  }
}
