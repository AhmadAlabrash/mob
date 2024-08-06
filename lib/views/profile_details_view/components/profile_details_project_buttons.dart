import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/utils/components/alerts.dart';

import '../../../helper/local_keys.g.dart';
import '../../../view_models/profile_details_view_model/profile_details_view_model.dart';

class ProfileDetailsProjectButtons extends StatelessWidget {
  const ProfileDetailsProjectButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final pdm = ProfileDetailsViewModel.instance;
    return ValueListenableBuilder(
      valueListenable: pdm.viewAsClient,
      builder: (context, value, child) => Row(
        children: [
          Expanded(
            flex: 16,
            child: OutlinedButton(
              onPressed: () {},
              child: Text(LocalKeys.viewProject),
            ),
          ),
          if (!value) const Expanded(flex: 1, child: SizedBox()),
          if (!value)
            Expanded(
              flex: 16,
              child: ElevatedButton(
                onPressed: () async {
                  Alerts().normalAlert(
                    context: context,
                    title: LocalKeys.workSubmitted,
                    description: LocalKeys.yourWorkHasBeenSubmitted,
                    buttonText: LocalKeys.backToHome,
                    onConfirm: () async {
                      context.popTrue;
                      return true;
                    },
                    buttonColor: context.dProvider.greenColor,
                  );
                },
                child: Text(LocalKeys.editProject),
              ),
            ),
        ],
      ),
    );
  }
}
