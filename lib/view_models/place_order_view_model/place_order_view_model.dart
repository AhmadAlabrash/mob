import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/services/place_order_service.dart';
import 'package:xilancer/services/profile_info_service.dart';
import 'package:xilancer/view_models/onboarding_view_model/onboarding_view_model.dart';
// import 'package:http/http.dart' as http;
import 'package:xilancer/view_models/place_order_view_model/milestone_model.dart';
import 'package:xilancer/view_models/place_order_view_model/payment_methode_navigator_helper.dart';
import 'package:xilancer/views/onboarding_view/onboarding_view.dart';
import 'package:xilancer/views/proccess_status_view/place_order_status_view.dart';

import '../../app_static_values.dart';
import '../../helper/extension/string_extension.dart';
import '../../helper/local_keys.g.dart';
import '../../models/payment_gateway_model.dart';
import '../../views/my_order_details_view/my_order_details_view.dart';

class PlaceOrderViewViewModel {
  ValueNotifier<bool> walletSelect = ValueNotifier(false);
  ValueNotifier<bool> addMilestones = ValueNotifier(false);
  ValueNotifier<bool> tacPP = ValueNotifier(false);
  ValueNotifier<bool> isLoading = ValueNotifier(false);
  ValueNotifier<Gateway?> selectedGateway = ValueNotifier(null);
  ValueNotifier<String?> selectedDDate = ValueNotifier(jobLengths.firstOrNull);
  ValueNotifier<List<Milestone>> milestones = ValueNotifier([]);
  ValueNotifier<File?> selectedAttachment = ValueNotifier(null);
  // Map mile = {};
  // var request =
  //     http.MultipartRequest('POST', Uri.parse("AppUrls.placeOrderUrl"));

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController revisionController = TextEditingController();
  TextEditingController aCardController = TextEditingController();
  TextEditingController zUsernameController = TextEditingController();
  TextEditingController authCodeController = TextEditingController();

  ValueNotifier<DateTime?> authNetExpireDate = ValueNotifier(null);

  final GlobalKey<FormState> formKey = GlobalKey(debugLabel: "milestone_sheet");

  PlaceOrderViewViewModel._init();
  static PlaceOrderViewViewModel? _instance;
  static PlaceOrderViewViewModel get instance {
    _instance ??= PlaceOrderViewViewModel._init();
    return _instance!;
  }

  PlaceOrderViewViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  setAttachFile() async {
    try {
      PickedFile? file = await ImagePicker.platform.pickImage(
          source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);
      if (file == null) {
        return;
      }
      selectedAttachment.value = File(file.path);
      LocalKeys.fileSelected.showToast();
    } catch (error) {
      LocalKeys.fileSelectFailed.showToast();
    }
  }

  resetMilestoneSheet({
    name,
    price,
    desc,
    revision,
    dTime,
  }) {
    selectedDDate.value = dTime ?? jobLengths.firstOrNull;
    nameController.text = name ?? "";
    priceController.text = price?.toString() ?? "";
    descriptionController.text = desc ?? "";
    revisionController.text = revision?.toString() ?? "";
  }

  void addMilestone(BuildContext context) {
    final valid = formKey.currentState?.validate();
    if (valid != true) {
      return;
    }
    if (selectedDDate.value == null) {
      LocalKeys.selectDeliveryTime.showToast();
      return;
    }
    final id = milestones.value.length;
    milestones.value.add(
      Milestone(
        id: id,
        name: nameController.text,
        description: descriptionController.text,
        price: priceController.text.tryToParse,
        revision: revisionController.text.tryToParse,
        dTime: selectedDDate.value!,
      ),
    );
    milestones.notifyListeners();
    context.pop;
  }

  void editMilestone(BuildContext context, id) {
    final valid = formKey.currentState?.validate();
    if (valid != true) {
      return;
    }
    if (selectedDDate.value == null) {
      LocalKeys.selectDeliveryTime.showToast();
      return;
    }
    milestones.value[id] = Milestone(
      id: milestones.value.length,
      name: nameController.text,
      description: descriptionController.text,
      price: priceController.text.tryToParse,
      revision: revisionController.text.tryToParse,
      dTime: selectedDDate.value!,
    );
    milestones.notifyListeners();
    context.pop;
  }

  void removeMilestone(id) {
    milestones.value
        .removeWhere((element) => element.id.toString() == id.toString());
    milestones.notifyListeners();
  }

  bool get paymentValidate {
    bool valid = true;
    if (walletSelect.value) {
      return true;
    }
    switch (selectedGateway.value?.name) {
      case "authorize_dot_net":
        if (authCodeController.text.length < 3 ||
            aCardController.text.length < 16 ||
            authNetExpireDate.value == null) {
          LocalKeys.pleaseProvideYourCardInformation.showToast();
          return false;
        }
        break;
      case "manual_payment":
        if (selectedAttachment.value == null) {
          LocalKeys.selectFile.showToast();
          return false;
        }
        break;
      case "zitopay":
        if (zUsernameController.text.isEmpty) {
          LocalKeys.enterUsername.showToast();
          return false;
        }
        break;
      default:
    }
    return valid;
  }

  void tryPlacingOrder(
      {required BuildContext context,
      required projectId,
      required jobId,
      required proposalId,
      required offerId}) async {
    final poProvider = Provider.of<PlaceOrderService>(context, listen: false);
    bool orderSuccess = false;
    if (selectedGateway.value == null && !walletSelect.value) {
      LocalKeys.selectAPaymentMethod.showToast();
      return;
    }

    if (!paymentValidate) {
      debugPrint("payment invalidate".toString());
      return;
    }
    isLoading.value = true;
    orderSuccess = await poProvider.projectPlaceOrder(
          projectId: projectId,
          offerId: offerId,
          proposalId: proposalId,
          jobId: jobId,
        ) ??
        false;
    if (!orderSuccess) {
      isLoading.value = false;
      return;
    }

    final po = Provider.of<PlaceOrderService>(context, listen: false);
    final pi = Provider.of<ProfileInfoService>(context, listen: false);

    final userEmail = pi.profileInfoModel.data?.email;
    final userPhone = pi.profileInfoModel.data?.phone;
    final userName = pi.profileInfoModel.data?.firstName;
    final userCity = pi.profileInfoModel.data?.city;
    final userAddress = pi.profileInfoModel.data?.city;
    final id = po.orderId;
    if (selectedGateway.value?.name == "manual_payment" || walletSelect.value) {
      isLoading.value = false;
      context.toPage(PlaceOrderStatusView(
          title: LocalKeys.orderPlacedSuccessfully,
          updateStatus: false,
          description: id != null ? "${LocalKeys.orderId}: #$id" : null,
          ebText: LocalKeys.backToHome,
          ebOnTap: (BuildContext context) {
            OnboardingViewModel.dispose;
            context.toUntilPage(const OnboardingView());
          },
          onWillPop: (BuildContext context) {
            OnboardingViewModel.dispose;
            context.toUntilPage(const OnboardingView());
          },
          obOnTap: (BuildContext context) {
            OnboardingViewModel.dispose;
            context.toUntilPage(const OnboardingView());
            context.toNamed(MyOrderDetailsView.routeName, arguments: id);
          },
          obText: LocalKeys.viewDetails,
          status: 1));
      return;
    }
    await startPayment(
      context,
      authNetCard: aCardController.text,
      authcCode: aCardController.text,
      zUsername: zUsernameController.text,
      authNetED: authNetExpireDate.value,
      onSuccess: () {
        context.toPage(PlaceOrderStatusView(
          title: LocalKeys.paymentSuccess,
          description: id != null ? "${LocalKeys.orderId}: #$id" : null,
          ebText: LocalKeys.backToHome,
          ebOnTap: (BuildContext context) {
            OnboardingViewModel.dispose;
            context.toUntilPage(const OnboardingView());
          },
          onWillPop: (BuildContext context) {
            OnboardingViewModel.dispose;
            context.toUntilPage(const OnboardingView());
          },
          obOnTap: (BuildContext context) {
            OnboardingViewModel.dispose;
            context.toUntilPage(const OnboardingView());
            context.toNamed(MyOrderDetailsView.routeName, arguments: id);
          },
          obText: LocalKeys.viewDetails,
          status: 1,
        ));
      },
      onFailed: () {
        context.toPage(PlaceOrderStatusView(
            title: LocalKeys.paymentFailed,
            // description: id != null ? "${LocalKeys.orderId}: #$id" : null,
            ebText: LocalKeys.backToHome,
            updateStatus: false,
            onWillPop: (BuildContext context) {
              OnboardingViewModel.dispose;
              context.toUntilPage(const OnboardingView());
            },
            ebOnTap: (BuildContext context) {
              OnboardingViewModel.dispose;
              context.toUntilPage(const OnboardingView());
            },
            // obText: LocalKeys.viewDetails,
            status: 0));
      },
      orderId: po.orderId,
      amount: po.amount,
      selectedGateway: selectedGateway.value!,
      userEmail: userEmail,
      userName: userName,
      userPhone: userPhone,
      userCity: userCity,
      userAddress: userAddress,
    );
    isLoading.value = false;
  }
}
