import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/job_details_service.dart';
import 'package:xilancer/services/job_list_service.dart.dart';
import 'package:xilancer/utils/components/alerts.dart';

import '../../views/place_order_view/place_order_view.dart';
import '../place_order_view_model/place_order_view_model.dart';

class FixPriceJobDetailsViewModel {
  ValueNotifier<int> selectedIndex = ValueNotifier(0);
  ValueNotifier<int> feedbackIndex = ValueNotifier(0);
  List historyTitles = [
    LocalKeys.thisWeek,
    LocalKeys.thisMonth,
    LocalKeys.last6Month,
    LocalKeys.thisYear,
  ];
  List feedbackTitles = [
    LocalKeys.yourFeedback,
    LocalKeys.clientsFeedback,
  ];

  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController amountController = TextEditingController();
  TextEditingController revisionController = TextEditingController();
  TextEditingController cLaterController = TextEditingController();
  ValueNotifier<String?> dTime = ValueNotifier(null);
  ValueNotifier<File?> aFile = ValueNotifier(null);
  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<bool> acceptLoading = ValueNotifier(false);

  ValueNotifier<int> selectedTitleIndex = ValueNotifier(0);

  FixPriceJobDetailsViewModel._init();
  static FixPriceJobDetailsViewModel? _instance;
  static FixPriceJobDetailsViewModel get instance {
    _instance ??= FixPriceJobDetailsViewModel._init();
    return _instance!;
  }

  FixPriceJobDetailsViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  get dTimeValidate {
    if (dTime.value == null) {
      LocalKeys.selectDeliveryTime.showToast();
      return false;
    }
    return true;
  }

  tryClosingJob(BuildContext context, {id, jobStatus}) async {
    final jdProvider = Provider.of<JobDetailsService>(context, listen: false);
    Alerts().confirmationAlert(
        context: context,
        title: LocalKeys.areYouSure,
        buttonColor: context.dProvider.primaryColor,
        onConfirm: () async {
          await jdProvider
              .tryClosingJob(id.toString(), jobStatus)
              .then((value) {
            if (value == true) {
              try {
                final jlProvider =
                    Provider.of<JobListService>(context, listen: false);
                jlProvider.changeJobStatus(id, jobStatus);
              } catch (e) {}
              context.popFalse;
            }
            loading.value = false;
          });
        });
  }

  void tryRejecting(BuildContext context, {id}) {
    final jdProvider = Provider.of<JobDetailsService>(context, listen: false);
    Alerts().confirmationAlert(
      context: context,
      title: LocalKeys.areYouSure,
      buttonText: LocalKeys.reject,
      buttonColor: context.dProvider.warningColor,
      onConfirm: () async {
        await jdProvider.tryRejectingProposal(id: id);
        context.pop;
      },
    );
  }

  void tryAddingShortList(BuildContext context,
      {id, required bool shortlisted}) {
    final jdProvider = Provider.of<JobDetailsService>(context, listen: false);
    Alerts().confirmationAlert(
      context: context,
      title: LocalKeys.areYouSure,
      buttonColor: context.dProvider.primaryColor,
      buttonText: shortlisted ? LocalKeys.remove : LocalKeys.add,
      onConfirm: () async {
        await jdProvider.tryAddingToShortlist(id: id, shortlisted: shortlisted);
        context.pop;
      },
    );
  }

  void tryAcceptingProposal(BuildContext context, {id}) {
    final jdProvider = Provider.of<JobDetailsService>(context, listen: false);
    PlaceOrderViewViewModel.dispose;
    context.toPage(PlaceOrderView(
      jobId: jdProvider.id,
      proposalId: id,
    ));
  }
}
