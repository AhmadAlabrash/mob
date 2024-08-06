import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import 'package:xilancer/helper/extension/int_extension.dart';
import 'package:xilancer/helper/extension/string_extension.dart';
import 'package:xilancer/models/conversation_model.dart';
import 'package:xilancer/utils/components/alerts.dart';
import 'package:xilancer/views/project_details_view/project_details_view.dart';

import '../../../helper/local_keys.g.dart';
import '../../../helper/svg_assets.dart';
import '../../../services/bookmark_data_service.dart';

class ProjectDetailsButtons extends StatelessWidget {
  const ProjectDetailsButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton.icon(
          onPressed: () async {
            //
          },
          icon: SvgAssets.message.toSVG,
          label: Text(LocalKeys.sendMessage),
        ),
        20.toWidth,
      ],
    );
  }
}
