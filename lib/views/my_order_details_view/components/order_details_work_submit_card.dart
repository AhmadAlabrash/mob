import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

import 'package:xilancer/helper/constant_helper.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/helper/extension/widget_extension.dart';
import 'package:xilancer/helper/local_keys.g.dart';
import 'package:xilancer/helper/svg_assets.dart';
import 'package:xilancer/themes/default_themes.dart';
import 'package:xilancer/view_models/my_order_details_view_model/my_order_details_view_model.dart';
import 'package:xilancer/views/my_order_details_view/components/request_revision_sheet.dart';

class OrderDetailsWorkSubmitCard extends StatelessWidget {
  final DateTime? submitDate;
  final status;
  final String? attachmentUrl;
  final String? description;
  final orderId;
  final orderWorkId;
  final milestoneId;

  const OrderDetailsWorkSubmitCard(
      {super.key,
      this.submitDate,
      this.status,
      this.attachmentUrl,
      this.orderId,
      required this.orderWorkId,
      required this.milestoneId,
      this.description});

  @override
  Widget build(BuildContext context) {
    final mod = MyOrderDetailsViewModel.instance;
    debugPrint(attachmentUrl.toString());
    return ExpansionTile(
      tilePadding: const EdgeInsets.symmetric(horizontal: 20),
      childrenPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          side: BorderSide(
        color: context.dProvider.whiteColor,
      )),
      collapsedShape: RoundedRectangleBorder(
          side: BorderSide(
        color: context.dProvider.whiteColor,
      )),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                DateFormat("MMM dd, yyyy", dProvider.languageSlug)
                    .format(submitDate!),
                style: context.titleMedium?.bold6,
              ),
              8.toWidth,
              GestureDetector(
                onTap: "1" != "2"
                    ? null
                    : () {
                        showGeneralDialog(
                          context: context,
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: context.width / 1.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: context.dProvider.whiteColor,
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      LocalKeys.revision,
                                      style: context.titleMedium?.bold6,
                                    ).hp20,
                                    Divider(
                                      color: context.dProvider.black8,
                                      thickness: 2,
                                      height: 36,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: status.toString() != "1"
                            ? context.dProvider.yellowColor
                            : context.dProvider.primaryColor,
                      )),
                  child: Text(
                    status.toString().getWSHStatus.capitalize,
                    style: context.titleSmall?.copyWith(
                        color: status.toString() != "1"
                            ? context.dProvider.yellowColor
                            : context.dProvider.primaryColor),
                  ),
                ),
              ),
            ],
          ),
          TextButton.icon(
            onPressed: () async {
              await urlLauncher.launch(attachmentUrl ?? "");
            },
            icon: SvgAssets.documentDownload
                .toSVGSized(20, color: context.dProvider.primaryColor),
            label: Text(LocalKeys.downloadAttachment),
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
          ),
          4.toHeight,
          if (status.toString() == "0")
            Wrap(
              spacing: 12,
              runSpacing: 4,
              children: [
                OutlinedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isDismissible: false,
                      isScrollControlled: true,
                      builder: (context) => RequestRevisionSheet(
                        orderWorkId: orderWorkId,
                        milestoneId: milestoneId,
                        orderId: orderId,
                      ),
                    );
                  },
                  child: Text(LocalKeys.requestRevision),
                ),
                ElevatedButton(
                  onPressed: () {
                    mod.tryAcceptOrder(
                      context,
                      orderId: orderId,
                      milestoneId: milestoneId,
                    );
                  },
                  child: Text(LocalKeys.accept),
                ),
              ],
            )
        ],
      ),
      children: description == null || description == ""
          ? []
          : [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HtmlWidget(
                    description!,
                  ).hp20,
                ],
              )
            ],
    );
  }
}
