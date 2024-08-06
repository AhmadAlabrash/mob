import 'package:flutter/material.dart';
import '/helper/extension/context_extension.dart';
import '/helper/local_keys.g.dart';
import '/utils/components/alerts.dart';

class ActiveStatusTile extends StatelessWidget {
  const ActiveStatusTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ValueNotifier activeStatus = ValueNotifier(false);
    return Container(
      height: 52,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          LocalKeys.activeStatus,
          style: context.titleMedium?.bold6,
        ),
        ValueListenableBuilder(
          valueListenable: activeStatus,
          builder: (context, value, child) => Transform.scale(
            scale: .8,
            child: Switch(
              value: value,
              onChanged: (newValue) async {
                await Alerts().confirmationAlert(
                  context: context,
                  title: LocalKeys.areYouSure,
                  onConfirm: () {
                    activeStatus.value = newValue;

                    context.popFalse;
                    return Future.value();
                  },
                  buttonText: LocalKeys.confirm,
                  buttonColor: context.dProvider.primaryColor,
                );
              },
            ),
          ),
        )
      ]),
    );
  }
}
