import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/utils/components/custom_button.dart';
import 'package:xilancer/view_models/create_job_view_model/create_job_view_model.dart';

import '../../../helper/local_keys.g.dart';

class CreateProjectButtons extends StatelessWidget {
  final lastPage;
  const CreateProjectButtons({super.key, this.lastPage = false});

  @override
  Widget build(BuildContext context) {
    final cpv = CreateJobViewModel.instance;
    return Row(
      children: [
        Expanded(
          flex: 16,
          child: OutlinedButton(
            onPressed: () {
              context.unFocus;
              cpv.goBack(context);
            },
            child: Text(LocalKeys.back),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
            flex: 16,
            child: ValueListenableBuilder(
              valueListenable: CreateJobViewModel.instance.isLoading,
              builder: (context, isLoading, child) {
                return CustomButton(
                  onPressed: () async {
                    context.unFocus;
                    cpv.nextPage(context);
                  },
                  btText: lastPage
                      ? cpv.jobId != null
                          ? LocalKeys.saveChanges
                          : LocalKeys.createJob
                      : LocalKeys.next,
                  isLoading: isLoading,
                );
              },
            )),
      ],
    );
  }
}
