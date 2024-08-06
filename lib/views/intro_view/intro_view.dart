import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/helper/extension/context_extension.dart';
import '/views/intro_view/components/intro_pages.dart';

import '../../services/intro_service.dart';
import 'components/intro_base.dart';

class IntroView extends StatelessWidget {
  static const routeName = "intro_view";
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = PageController();
    return Consumer<IntroService>(builder: (context, iProvider, child) {
      return Material(
        color: Colors.transparent,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.dProvider.primaryColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IntroPages(controller: controller),
                    IntroBase(controller: controller),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
