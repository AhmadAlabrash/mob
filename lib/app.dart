import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:xilancer/main.dart';

import '/views/splash_view/splash_view.dart';
import 'helper/constant_helper.dart';
import 'helper/routes.dart';
import 'services/dynamics/dynamics_service.dart';
import 'customizations.dart';
import 'helper/providers.dart';
import 'themes/default_themes.dart';

class XilancerApp extends StatelessWidget {
  const XilancerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: Consumer<DynamicsService>(
        builder: (context, dProvider, child) {
          print("auto Building");
          coreInit(context);
          return FutureBuilder(
              future: dProvider.onceRebuilt ? null : dProvider.getColors(),
              builder: (context, sn) {
                return MaterialApp(
                  navigatorKey: navigatorKey,
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: [
                    dProvider.appLocal,
                    const Locale('en', "US")
                  ],
                  builder: (context, rtlChild) {
                    return Directionality(
                      textDirection: dProvider.textDirectionRight
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      child: rtlChild!,
                    );
                  },
                  title: appLabel,
                  theme: DefaultThemes().themeData(context, dProvider),
                  home: child,
                  routes: Routes.routes,
                );
              });
        },
        child: const SplashView(),
      ),
    );
  }
}
