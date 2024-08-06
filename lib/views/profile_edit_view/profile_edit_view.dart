import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/phone_field.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/utils/components/city_dropdown.dart';
import 'package:xilancer/utils/components/country_dropdown.dart';
import 'package:xilancer/utils/components/custom_dropdown.dart';
import 'package:xilancer/utils/components/field_label.dart';
import 'package:xilancer/utils/components/state_dropdown.dart';
import 'package:xilancer/view_models/profile_edit_view_model.dart/profile_edit_view_model.dart';
import 'package:xilancer/views/profile_settings_view/components/profile_info_avatar.dart';
import 'package:xilancer/views/sign_up_view/components/name_field.dart';

import '../../utils/components/field_with_label.dart';
import '../../utils/components/navigation_pop_icon.dart';
import '../../utils/components/custom_button.dart';
import '/helper/local_keys.g.dart';

class ProfileEditView extends StatelessWidget {
  static const routeName = 'profile_edit_view';
  const ProfileEditView({super.key});

  @override
  Widget build(BuildContext context) {
    final pev = ProfileEditViewModel.instance;

    pev.initEdit(context);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        leading: const NavigationPopIcon(),
        title: Text(LocalKeys.editProfile),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.dProvider.whiteColor,
          ),
          child: Form(
            key: pev.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      flex: 8,
                      child: ProfileInfoAvatar(
                        editing: true,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                pev.setProfileImage();
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgAssets.gallery.toSVGSized(20,
                                      color: context.dProvider.whiteColor),
                                  8.toWidth,
                                  Text(LocalKeys.changePhoto),
                                ],
                              )),
                          4.toHeight,
                          Text(
                            LocalKeys.profilePhotoShouldBeMinimum,
                            style: context.titleSmall
                                ?.copyWith(color: context.dProvider.black5),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                16.toHeight,
                NameField(
                  firstNameController: pev.firstNameController,
                  lastNameController: pev.lastNameController,
                ),
                FieldWithLabel(
                  label: LocalKeys.email,
                  hintText: LocalKeys.enterEmail,
                  keyboardType: TextInputType.emailAddress,
                  controller: pev.emailController,
                  validator: (value) {
                    if (!value!.validateEmail) {
                      return LocalKeys.enterValidEmailAddress;
                    }
                    return null;
                  },
                ),
                FieldWithLabel(
                  label: LocalKeys.phoneNumber,
                  hintText: LocalKeys.enterPhone,
                  keyboardType: TextInputType.number,
                  controller: pev.phoneController,
                  validator: (value) {
                    if (value!.length < 5) {
                      return LocalKeys.enterValidPhone;
                    }
                    return null;
                  },
                ),
                CountryDropdown(
                  countryNotifier: pev.selectedCountry,
                ),
                StateDropdown(
                  countryNotifier: pev.selectedCountry,
                  stateNotifier: pev.selectedState,
                ),
                CityDropdown(
                  stateNotifier: pev.selectedState,
                  cityNotifier: pev.selectedCity,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(20),
        color: Colors.transparent,
        child: ValueListenableBuilder(
          valueListenable: pev.loading,
          builder: (context, loading, child) => CustomButton(
            onPressed: () async {
              pev.updateProfileInfo(context);
            },
            btText: LocalKeys.saveChanges,
            isLoading: loading,
          ),
        ),
      ),
    );
  }
}
