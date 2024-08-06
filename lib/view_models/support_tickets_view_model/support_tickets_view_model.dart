import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/support_ticket_create_service.dart';
import 'package:xilancer/services/ticket_chat_service.dart';
import '../../models/ticket_list_model.dart';
import '../../services/ticket_list_service.dart';

class SupportTicketViewModel {
  final GlobalKey<FormState> formKey = GlobalKey();
  ScrollController scrollController = ScrollController();
  ScrollController chatScrollController = ScrollController();
  TextEditingController titleController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  ValueNotifier<String?> priority = ValueNotifier(null);
  ValueNotifier<Department?> department = ValueNotifier(null);
  ValueNotifier<bool> loading = ValueNotifier(false);

  SupportTicketViewModel._init();
  static SupportTicketViewModel? _instance;
  static SupportTicketViewModel get instance {
    _instance ??= SupportTicketViewModel._init();
    return _instance!;
  }

  SupportTicketViewModel._dispose();
  static bool get dispose {
    _instance = null;
    return true;
  }

  tryToLoadMoreMessages(BuildContext context) {
    try {
      final tlProvider = Provider.of<TicketChatService>(context, listen: false);
      final nextPageLoading = tlProvider.nextPageLoading;
      if (chatScrollController.position.pixels ==
          chatScrollController.position.maxScrollExtent) {
        if (!nextPageLoading && !tlProvider.noMoreMessages) {
          tlProvider.fetchOnlyMessages();
          return;
        }
      }
    } catch (e) {}
  }

  tryToLoadMore(BuildContext context) {
    try {
      final tlProvider = Provider.of<TicketListService>(context, listen: false);
      final String? nextPage = tlProvider.nextPage;
      final nextPageLoading = tlProvider.nextPageLoading;

      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (nextPage != null && !nextPageLoading) {
          tlProvider.fetchNextPage();
          return;
        }
      }
    } catch (e) {}
  }

  void createTicket(BuildContext context) {
    final isValid = formKey.currentState?.validate();
    if (isValid == false) {
      return;
    }
    if (department.value == null) {
      LocalKeys.selectDepartment.showToast();
      return;
    }
    if (priority.value == null) {
      LocalKeys.selectPriority.showToast();
      return;
    }

    loading.value = true;

    final ctProvider =
        Provider.of<SupportTicketCreateService>(context, listen: false);

    ctProvider
        .createTicket(
            title: titleController.text,
            description: descriptionController.text,
            priority: priority.value.toString(),
            subject: subjectController.text,
            selectedDepartment: department.value!)
        .then((v) async {
      if (v == true) {
        await Provider.of<TicketListService>(context, listen: false)
            .fetchTicketList();
        dispose;
        context.popFalse;
        loading.value = false;
      }
      loading.value = false;
    });
  }
}
