import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/context_extension.dart';

import '../../../helper/local_keys.g.dart';

class SendOfferButtons extends StatelessWidget {
  const SendOfferButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 16,
          child: OutlinedButton(
            onPressed: () {
              context.popFalse;
            },
            child: Text(LocalKeys.cancel),
          ),
        ),
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
          flex: 16,
          child: ElevatedButton(
            onPressed: () async {},
            child: Text(LocalKeys.sendOffer),
          ),
        ),
      ],
    );
  }
}
