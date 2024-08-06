import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helper/extension/context_extension.dart';
import '../../helper/local_keys.g.dart';
import '../../services/ticket_list_service.dart';
import '../../utils/components/custom_button.dart';
import '../../utils/components/custom_future_widget.dart';
import '../../utils/components/custom_preloader.dart';
import '../../utils/components/custom_refresh_indicator.dart';
import '../../utils/components/empty_spacer_helper.dart';
import '../../utils/components/empty_widget.dart';
import '../../utils/components/navigation_pop_icon.dart';
import '../../utils/components/scrolling_preloader.dart';
import '../../view_models/support_tickets_view_model/support_tickets_view_model.dart';
import '../../views/support_ticket_create_view/support_ticket_create_view.dart';
import '../../views/support_ticket_list_view/components/ticket_tile.dart';

import 'components/ticket_list_skeleton.dart';

class SupportTicketListView extends StatelessWidget {
  static const routeName = 'support_ticket_list_view';
  const SupportTicketListView({super.key});
  @override
  Widget build(BuildContext context) {
    final tlProvider = Provider.of<TicketListService>(context, listen: false);
    final stm = SupportTicketViewModel.instance;
    stm.scrollController.addListener(() {
      stm.tryToLoadMore(context);
    });
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
        title: Text(LocalKeys.supportTicket),
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await tlProvider.fetchTicketList();
        },
        child: CustomFutureWidget(
            function: tlProvider.shouldAutoFetch
                ? tlProvider.fetchTicketList()
                : null,
            shimmer: const TicketListSkeleton(),
            child: Consumer<TicketListService>(builder: (context, tl, child) {
              return tl.ticketList.isEmpty
                  ? EmptyWidget(title: LocalKeys.noTicketFound)
                  : Scrollbar(
                      controller: stm.scrollController,
                      child: ListView.separated(
                          controller: stm.scrollController,
                          padding: const EdgeInsets.all(20),
                          itemBuilder: (context, index) {
                            if (tl.nextPage != null && 12 == (index)) {
                              return ScrollPreloader(
                                  loading: tl.nextPageLoading);
                            }
                            final tItem = tl.ticketList[index];
                            return TicketTile(
                                id: tItem.id.toString(),
                                title: tItem.title,
                                ticketId: tItem.id,
                                priority: tItem.priority,
                                status: tItem.status);
                          },
                          separatorBuilder: (context, index) =>
                              EmptySpaceHelper.emptyHeight(12),
                          itemCount: tl.ticketList.length +
                              (tl.nextPage != null && !tl.nexLoadingFailed
                                  ? 1
                                  : 0)),
                    );
            })),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: CustomButton(
            onPressed: () {
              context.toNamed(SupportTicketCreateView.routeName);
            },
            btText: LocalKeys.createTicket,
            isLoading: false),
      ),
    );
  }
}
