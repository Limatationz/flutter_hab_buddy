import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:collection/collection.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:dynamic_themes/dynamic_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

import 'core/routing/router.dart';
import 'generated/l10n.dart';
import 'locator.dart';
import 'view/util/text_styles.g.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Splash Screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Hive
  await Hive.initFlutter();

  _setupLogging();
  setupLocator();

  // Set Theme
  StreamingSharedPreferences prefs = await StreamingSharedPreferences.instance;
  var systemBrightness = SchedulerBinding.instance.window.platformBrightness;
  var selectedBrightness =
      prefs.getInt('appTheme', defaultValue: -1).getValue();
  bool isDarkMode = systemBrightness == Brightness.dark;
  switch (selectedBrightness) {
    case 0:
      isDarkMode = false;
      break;
    case 1:
      isDarkMode = true;
      break;
  }

  await Future.wait([
    locator.allReady(),
    initHyphenation(),
  ]);

  runApp(DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
    ColorScheme lightColorScheme;
    ColorScheme darkColorScheme;

    if (lightDynamic != null && darkDynamic != null && false) {
      lightColorScheme = lightDynamic.harmonized();
      darkColorScheme = darkDynamic.harmonized();
    } else {
      // Otherwise, use fallback schemes.
      lightColorScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFFEC815F),
      );
      darkColorScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFFD5562E),
        brightness: Brightness.dark,
      );
    }

    //Theme
    final themeLight =
        ThemeData.from(colorScheme: lightColorScheme, textTheme: textTheme, useMaterial3: true);

    final themeDark =
        ThemeData.from(colorScheme: darkColorScheme, textTheme: textTheme, useMaterial3: true);

    final themeCollection = ThemeCollection(
      themes: {
        0: themeLight,
        1: themeDark,
      },
      fallbackTheme: ThemeData.light(
          useMaterial3:
              true), // optional fallback theme, default value is ThemeData.light()
    );

    return DynamicTheme(
        themeCollection: themeCollection,
        defaultThemeId: isDarkMode ? 1 : 0,
        builder: (context, theme) {
          final locale = S.delegate.supportedLocales.firstWhereOrNull(
              (element) =>
                  element.languageCode ==
                  prefs.getString('language', defaultValue: '').getValue());

          final systemNavigationBarColor = ElevationOverlay.applySurfaceTint(
              theme.colorScheme.surface, theme.colorScheme.surfaceTint, 3);

          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: theme.brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
              statusBarBrightness: theme.brightness,
              systemNavigationBarColor: systemNavigationBarColor,
              systemNavigationBarIconBrightness:
                  theme.brightness == Brightness.dark
                      ? Brightness.light
                      : Brightness.dark,
              systemNavigationBarDividerColor: theme.colorScheme.background));

          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: "OpenHAB Home",
            routerConfig: router,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: locale,
            theme: theme,
          );
        });
  }));
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    debugPrint('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
