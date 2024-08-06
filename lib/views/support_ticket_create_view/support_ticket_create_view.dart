import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import '../../helper/local_keys.g.dart';
import '../../services/ticket_list_service.dart';
import '../../utils/components/custom_button.dart';
import '../../utils/components/custom_future_widget.dart';
import '../../utils/components/custom_preloader.dart';
import '../../utils/components/empty_spacer_helper.dart';
import '../../utils/components/field_label.dart';
import '../../utils/components/field_with_label.dart';
import '../../utils/components/navigation_pop_icon.dart';
import '../../view_models/support_tickets_view_model/support_tickets_view_model.dart';

import '../../utils/components/custom_dropdown.dart';

class SupportTicketCreateView extends StatelessWidget {
  static const routeName = 'support_ticket_create_view';
  const SupportTicketCreateView({super.key});
  @override
  Widget build(BuildContext context) {
    final stm = SupportTicketViewModel.instance;
    return Scaffold(
        appBar: AppBar(
          leading: const NavigationPopIcon(),
          title: Text(LocalKeys.createTicket),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: context.dProvider.whiteColor),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: stm.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FieldWithLabel(
                    label: LocalKeys.title,
                    hintText: LocalKeys.enterTitle,
                    controller: stm.titleController,
                    validator: (title) {
                      if (title!.isEmpty || title.trim().length < 4) {
                        return LocalKeys.enterValidTitle;
                      }
                      return null;
                    },
                  ),
                  FieldWithLabel(
                    label: LocalKeys.subject,
                    hintText: LocalKeys.enterASubject,
                    controller: stm.subjectController,
                    validator: (title) {
                      if (title!.isEmpty || title.trim().length < 4) {
                        return LocalKeys.enterValidTitle;
                      }
                      return null;
                    },
                  ),
                  FieldLabel(label: LocalKeys.priority),
                  Consumer<TicketListService>(
                      builder: (context, tlProvider, child) {
                    stm.priority.value = tlProvider.priorityList.first;
                    return ValueListenableBuilder(
                      valueListenable: stm.priority,
                      builder: (context, priority, child) => CustomDropdown(
                        LocalKeys.selectPriority,
                        tlProvider.priorityList,
                        (value) {
                          stm.priority.value = value as String;
                        },
                        value: priority,
                      ),
                    );
                  }),
                  FieldLabel(label: LocalKeys.department),
                  Consumer<TicketListService>(
                      builder: (context, tlProvider, child) {
                    return CustomFutureWidget(
                        function: 1 == 1 ? tlProvider.fetchDepartments() : null,
                        shimmer: const CustomPreloader(),
                        child: Builder(
                          builder: (context) {
                            return ValueListenableBuilder(
                              valueListenable: stm.department,
                              builder: (context, department, child) =>
                                  CustomDropdown(
                                LocalKeys.selectDepartment,
                                tlProvider.departments
                                        ?.map((e) => e.name)
                                        .toList() ??
                                    [],
                                (value) {
                                  stm.department.value = tlProvider.departments
                                      ?.firstWhere(
                                          (element) => element.name == value);
                                },
                                value: department?.name,
                              ),
                            );
                          },
                        ));
                  }),
                  EmptySpaceHelper.emptyHeight(8),
                  FieldLabel(label: LocalKeys.description),
                  TextFormField(
                    maxLines: 3,
                    minLines: 3,
                    controller: stm.descriptionController,
                    decoration: InputDecoration(
                      hintText: LocalKeys.enterSomeDescription,
                    ),
                    validator: (description) {
                      if (description!.isEmpty ||
                          description.trim().length < 20) {
                        return LocalKeys.enterValidDescription;
                      }
                      return null;
                    },
                  ),
                  EmptySpaceHelper.emptyHeight(20),
                  ValueListenableBuilder(
                    valueListenable: stm.loading,
                    builder: (context, loading, child) => CustomButton(
                        onPressed: () {
                          Provider.of<TicketListService>(context, listen: false)
                              .fetchDepartments();
                          stm.createTicket(context);
                        },
                        btText: LocalKeys.createTicket,
                        isLoading: loading),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
