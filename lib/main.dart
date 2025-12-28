import 'dart:ui';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:auto_hyphenating_text/auto_hyphenating_text.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:feedback_github/feedback_github.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:logging/logging.dart';

import 'core/hive/hive_registrar.g.dart';
import 'core/routing/router.dart';
import 'generated/l10n.dart';
import 'locator.dart';
import 'repository/login_repository.dart';
import 'view/util/text_styles.g.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Splash Screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Hive
  await Hive.initFlutter();
  Hive.registerAdapters();

  _setupLogging();
  setupLocator();

  await Future.wait([
    locator.allReady(),
    initHyphenation(),
  ]);

  final themeMode = await AdaptiveTheme.getThemeMode();
  bool isDark = themeMode == AdaptiveThemeMode.dark;
  if (themeMode == AdaptiveThemeMode.system) {
    final brightness = PlatformDispatcher.instance.platformBrightness;
    if (brightness == Brightness.dark) {
      isDark = true;
    } else {
      isDark = false;
    }
  }

  final isLoggedIn = await locator<LoginRepository>().checkLogin();
  final appRouter = router(isLoggedIn);

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
    final themeLight = ThemeData.from(
            colorScheme: lightColorScheme,
            textTheme: textTheme,
            useMaterial3: true)
        .copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightColorScheme.secondaryContainer.withValues(alpha: 0.4),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        isDense: true,
      ),
    );

    final themeDark = ThemeData.from(
            colorScheme: darkColorScheme,
            textTheme: textTheme,
            useMaterial3: true)
        .copyWith(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkColorScheme.secondaryContainer.withValues(alpha: 0.4),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
      ),
    );

    return AdaptiveTheme(
        light: themeLight,
        dark: themeDark,
        initial: AdaptiveThemeMode.system,
        builder: (theme, darkTheme) {
          final currentTheme = isDark ? darkTheme : theme;

          setSystemOverlay(currentTheme);

          return BetterFeedback(
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: "HABBuddy",
              routerConfig: appRouter,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: theme,
              darkTheme: darkTheme,
              builder: (_, builder) => Overlay(
                initialEntries: [
                  OverlayEntry(builder: (_) => builder ?? const SizedBox.shrink())
                ], // https://github.com/Stacked-Org/stacked/issues/1178
              ),
            ),
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

void setSystemOverlay(ThemeData theme) {
  final systemNavigationBarColor = ElevationOverlay.applySurfaceTint(
      theme.colorScheme.surface, theme.colorScheme.surfaceTint, 3);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: theme.brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      statusBarBrightness: theme.brightness,
      systemNavigationBarColor: systemNavigationBarColor,
      systemNavigationBarIconBrightness: theme.brightness == Brightness.dark
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarDividerColor: theme.colorScheme.surface));
}
