import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';

import '../../../helper/local_keys.g.dart';
import '../../../helper/svg_assets.dart';
import '../../../services/ticket_chat_service.dart';
import '../../../services/ticket_list_service.dart';
import '../../ticket_chat_view/ticket_chat_view.dart';

class TicketTile extends StatelessWidget {
  final String title;
  final int ticketId;
  final String priority;
  final String status;
  final id;
  const TicketTile({
    this.id,
    required this.title,
    required this.ticketId,
    required this.priority,
    required this.status,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Provider.of<TicketChatService>(context, listen: false)
            .fetchSingleTickets(context, id)
            .then((value) {
          if (value != null) {
            value.toString().showToast();
          }
        }).onError((error, stackTrace) {});
        Navigator.of(context).push(MaterialPageRoute<void>(
          builder: (BuildContext context) => TicketChatView(title, ticketId),
        ));
      }),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.dProvider.whiteColor,
          border: Border.all(color: context.dProvider.black8),
        ),
        child: Column(
          children: [
            SizedBox(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Text(
                  '#$ticketId',
                  style: TextStyle(
                      color: context.dProvider.primaryColor, fontSize: 13),
                ),
                const SizedBox(width: 10),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: context.titleMedium,
                ),
                const Spacer(),
              ],
            )),
            const SizedBox(height: 45),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: (context.width - 40) / 3.1,
                  child: Consumer<TicketListService>(
                      builder: (context, tlProvider, child) {
                    return SizedBox(
                      height: 30,
                      child: FittedBox(
                        child: Row(
                          children: [
                            Text('${LocalKeys.priority}:'),
                            const SizedBox(width: 5),
                            Consumer<TicketListService>(
                                builder: (context, tlProviderm, child) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: tlProvider.priorityColor[
                                          priority.toLowerCase()] ??
                                      tlProvider.priorityColor.values.first,
                                ),
                                child: Text(
                                  priority.toString().capitalize,
                                  style: TextStyle(
                                      color: context.dProvider.whiteColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600),
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(width: 5),
                SizedBox(
                  height: 30,
                  width: (context.width - 40) / 3.1,
                  child: Consumer<TicketListService>(
                      builder: (context, tlProvider, child) {
                    return FittedBox(
                      child: Row(
                        children: [
                          Text('${LocalKeys.status}:'),
                          const SizedBox(width: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: status == 'open'
                                  ? context.dProvider.greenColor
                                  : context.dProvider.black7,
                            ),
                            child: Text(
                              status.capitalize,
                              style: TextStyle(
                                  color: context.dProvider.whiteColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
                const Spacer(),
                SizedBox(
                    height: 25,
                    child: FittedBox(
                      child: GestureDetector(
                        child: Container(
                          height: 30,
                          width: 40,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: context.dProvider.primaryColor,
                          ),
                          child: SvgAssets.invisible.toSVGSized(20,
                              color: context.dProvider.whiteColor),
                        ),
                      ),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
