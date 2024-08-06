import 'package:flutter/material.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/view_models/conversation_view_model/conversation_view_model.dart';
import 'package:xilancer/views/conversation_view/components/conversations_buttons.dart';
import '/helper/extension/context_extension.dart';
import '/helper/local_keys.g.dart';

class ConversationInputBox extends StatelessWidget {
  final clientId;
  const ConversationInputBox({super.key, this.clientId});

  @override
  Widget build(BuildContext context) {
    final cm = ConversationViewModel.instance;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: context.dProvider.whiteColor,
          border: Border(top: BorderSide(color: context.dProvider.black7))),
      child: Column(
        children: [
          TextFormField(
            controller: cm.messageController,
            decoration: InputDecoration(
              hintText: '${LocalKeys.message}...',
            ),
          ),
          16.toHeight,
          ConversationButtons(
            clientId: clientId,
          )
        ],
      ),
    );
  }
}
