import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/utils/components/field_with_label.dart';
import 'package:xilancer/utils/components/warning_widget.dart';
import 'package:xilancer/view_models/my_order_details_view_model/my_order_details_view_model.dart';

class RequestRevisionSheet extends StatelessWidget {
  final orderId;
  final orderWorkId;
  final milestoneId;

  const RequestRevisionSheet({
    super.key,
    this.orderId,
    required this.orderWorkId,
    required this.milestoneId,
  });

  @override
  Widget build(BuildContext context) {
    final mod = MyOrderDetailsViewModel.instance;
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        color: context.dProvider.whiteColor,
      ),
      constraints: BoxConstraints(
          maxHeight:
              context.height / 2 + (MediaQuery.of(context).viewInsets.bottom)),
      child: Form(
          key: mod.revisionFormKey,
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: 4,
                  width: 48,
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: context.dProvider.black7,
                  ),
                ),
              ),
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WarningWidget(text: LocalKeys.revisionWarning),
                    16.toHeight,
                    FieldWithLabel(
                      label: LocalKeys.description,
                      hintText: LocalKeys.enterRevisionDescription,
                      minLines: 6,
                      controller: mod.revisionDescriptionController,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: OutlinedButton(
                              onPressed: () {
                                context.pop;
                              },
                              child: Text(LocalKeys.cancel)),
                        ),
                        12.toWidth,
                        Expanded(
                          flex: 1,
                          child: ValueListenableBuilder(
                            valueListenable: mod.isLoading,
                            builder: (context, value, child) {
                              return CustomButton(
                                onPressed: () {
                                  mod.tryRequestingRevision(
                                    context,
                                    orderWorkId: orderWorkId,
                                    orderId: orderId,
                                    milestoneId: milestoneId,
                                  );
                                },
                                btText: LocalKeys.sendRequest,
                                isLoading: value,
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ))
            ],
          )),
    );
  }
}
