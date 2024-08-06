import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/services/offer_details_service.dart';
import 'package:xilancer/utils/components/custom_future_widget.dart';
import 'package:xilancer/utils/components/custom_refresh_indicator.dart';
import 'package:xilancer/utils/components/empty_widget.dart';
import 'package:xilancer/views/my_offers_view/components/my_offer_card.dart';
import 'package:xilancer/views/my_offers_view/components/my_offers_skeleton.dart';
import 'package:xilancer/views/offer_details_view/components/offer_milestones.dart';

import '../../utils/components/navigation_pop_icon.dart';
import 'components/offer_cover_letter.dart';
import 'components/offer_details_skeleton.dart';

class OfferDetailsView extends StatelessWidget {
  final id;
  const OfferDetailsView({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    final odProvider = Provider.of<OfferDetailsService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: const NavigationPopIcon(),
        title: Text("#$id"),
      ),
      body: CustomRefreshIndicator(
        onRefresh: () async {
          await odProvider.fetchOfferDetail(id);
        },
        child: CustomFutureWidget(
            function: odProvider.shouldAutoFetch(id)
                ? odProvider.fetchOfferDetail(id)
                : null,
            shimmer: const OfferDetailsSkeleton(),
            child: Consumer<OfferDetailsService>(builder: (context, od, child) {
              final offerDetails = od.offerDetailsModel.offerDetails;
              return offerDetails == null
                  ? EmptyWidget(title: LocalKeys.offerDetailsNotFound)
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          MyOfferCard(
                            id: offerDetails.id.toString(),
                            budget: offerDetails.price,
                            createdAt: offerDetails.createdAt,
                            customerImage:
                                offerDetails.freelancer?.image?.profileImage,
                            customerName:
                                "${offerDetails.freelancer?.firstName ?? ""} ${offerDetails.freelancer?.lastName ?? ""}",
                            deadline: offerDetails.deadline,
                            offerStatus: offerDetails.status.toString(),
                          ),
                          OfferCoverLetter(
                            coverLetter: offerDetails.description,
                          ),
                          const OfferMilestones(),
                        ],
                      ),
                    );
            })),
      ),
    );
  }
}
