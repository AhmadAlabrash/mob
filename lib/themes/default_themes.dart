import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '/helper/extension/context_extension.dart';

class DefaultThemes {
  InputDecorationTheme? inputDecorationTheme(BuildContext context, dProvider) =>
      InputDecorationTheme(
          hintStyle: MaterialStateTextStyle.resolveWith((states) {
            return Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: dProvider.black5,
                  fontSize: 14,
                );
          }),
          counterStyle: MaterialStateTextStyle.resolveWith((states) {
            if (states.contains(MaterialState.focused)) {
              return context.titleSmall!
                  .copyWith(color: dProvider.primaryColor);
            }
            return Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: dProvider.blackColor);
          }),
          errorMaxLines: 3,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: dProvider.primaryColor, width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: dProvider.black8, width: 1),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: dProvider.black8, width: 1),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: dProvider.warningColor, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: dProvider.warningColor, width: 1),
          ),
          prefixIconColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.focused)) {
              return dProvider.primaryColor;
            }
            if (states.contains(MaterialState.error)) {
              return dProvider.warningColor;
            }
            return dProvider.black5;
          }));

  CheckboxThemeData? checkboxTheme(dProvider) => CheckboxThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide(
          width: 2,
          color: dProvider.black7,
        ),
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return dProvider.primaryColor;
          }
          return dProvider.whiteColor;
        }),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
            side: BorderSide(
              color: dProvider.primaryColor,
            )),
      );
  RadioThemeData? radioThemeData(dProvider) => RadioThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return dProvider.secondaryColor;
          }
          return dProvider.black5;
        }),
        visualDensity: VisualDensity.compact,
      );

  OutlinedButtonThemeData? outlinedButtonTheme(dProvider,
          {foregroundColor, color}) =>
      OutlinedButtonThemeData(
          style: ButtonStyle(
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((states) {
          return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
        }),
        side: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return BorderSide(
              color: dProvider.primaryColor,
            );
          }
          return BorderSide(
            color: color ?? dProvider.black8,
          );
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return dProvider.primaryColor;
          }
          return foregroundColor ?? dProvider.black5;
        }),
      ));

  ElevatedButtonThemeData? elevatedButtonTheme(dProvider) =>
      ElevatedButtonThemeData(
          style: ButtonStyle(
        elevation: MaterialStateProperty.resolveWith((states) => 0),
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>((states) {
          return RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
        }),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return dProvider.primaryColor.withOpacity(.05);
          }
          if (states.contains(MaterialState.pressed)) {
            return dProvider.blackColor;
          }
          return dProvider.primaryColor;
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return dProvider.black5;
          }
          if (states.contains(MaterialState.pressed)) {
            return dProvider.whiteColor;
          }
          return dProvider.whiteColor;
        }),
      ));
  TextButtonThemeData? textButtonThemeData(dProvider) => TextButtonThemeData(
          style: ButtonStyle(
        elevation: MaterialStateProperty.resolveWith((states) => 0),
        overlayColor:
            MaterialStateColor.resolveWith((states) => Colors.transparent),
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          return dProvider.blackColor.withOpacity(0.0);
        }),
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return dProvider.black5;
          }
          if (states.contains(MaterialState.pressed)) {
            return dProvider.blackColor;
          }
          return dProvider.primaryColor;
        }),
      ));

  appBarTheme(BuildContext context) => AppBarTheme(
        backgroundColor: context.dProvider.whiteColor,
        foregroundColor: context.dProvider.blackColor,
        titleTextStyle: context.titleLarge?.bold6,
        elevation: 3,
        surfaceTintColor: context.dProvider.whiteColor,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark),
      );

  themeData(BuildContext context, dProvider) => ThemeData(
        useMaterial3: true,
        primaryColor: dProvider.primaryColor,
        textTheme: GoogleFonts.getTextTheme('Inter'),
        scaffoldBackgroundColor: dProvider.black9,
        scrollbarTheme: scrollbarTheme(dProvider),
        appBarTheme: DefaultThemes().appBarTheme(context),
        elevatedButtonTheme: elevatedButtonTheme(dProvider),
        outlinedButtonTheme: outlinedButtonTheme(dProvider),
        inputDecorationTheme: inputDecorationTheme(context, dProvider),
        checkboxTheme: checkboxTheme(dProvider),
        textButtonTheme: textButtonThemeData(dProvider),
        switchTheme: switchThemeData(dProvider),
        popupMenuTheme: popupMenuTheme(context, dProvider),
        radioTheme: radioThemeData(dProvider),
      );
}

popupMenuTheme(BuildContext context, dProvider) {
  return PopupMenuThemeData(
      color: dProvider.whiteColor,
      surfaceTintColor: dProvider.whiteColor,
      textStyle: context.titleMedium);
}

SwitchThemeData switchThemeData(dProvider) => SwitchThemeData(
      thumbColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return dProvider.primary10;
        }
        return dProvider.whiteColor;
      }),
      trackColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (!states.contains(MaterialState.selected)) {
          return dProvider.warningColor.withOpacity(.60);
        }
        return dProvider.greenColor.withOpacity(.60);
      }),
      trackOutlineColor:
          MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
        if (!states.contains(MaterialState.selected)) {
          return dProvider.warningColor.withOpacity(.60);
        }
        return dProvider.greenColor.withOpacity(.40);
      }),
    );

ScrollbarThemeData scrollbarTheme(dProvider) => ScrollbarThemeData(
      thumbVisibility: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.scrolledUnder)) {
          return true;
        }
        return false;
      }),
      thickness: MaterialStateProperty.resolveWith((states) => 6),
      thumbColor:
          MaterialStateProperty.resolveWith((states) => dProvider.primary60),
    );
