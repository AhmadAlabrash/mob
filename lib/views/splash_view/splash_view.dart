import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/utils/components/custom_preloader.dart';
import '../../helper/local_keys.g.dart';
import '/services/dynamics/dynamics_service.dart';
import '/view_models/splash_view/splash_view_model.dart';
import '/helper/constant_helper.dart';
import '/helper/extension/context_extension.dart';

class SplashView extends StatelessWidget {
  static const routeName = '/';
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    coreInit(context);
    SplashViewModel().initiateStartingSequence(context);
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        top: false,
        bottom: false,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                color: context.dProvider.whiteColor,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/splash.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Consumer<DynamicsService>(builder: (context, lProvider, child) {
                return Positioned(
                    bottom: context.width / 2.5,
                    child: lProvider.noConnection
                        ? TextButton(
                            onPressed: () {
                              lProvider.setNoConnection(false);
                              SplashViewModel()
                                  .initiateStartingSequence(context);
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: context.dProvider.primaryColor,
                              backgroundColor: context.dProvider.whiteColor,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              surfaceTintColor: Colors.transparent,
                              splashFactory: NoSplash.splashFactory,
                              elevation: 0,
                            ),
                            child: Text(
                              LocalKeys.retry,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                      color: context.dProvider.primaryColor),
                            ),
                          )
                        : const CustomPreloader(
                            width: 80,
                            whiteColor: true,
                          ));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
