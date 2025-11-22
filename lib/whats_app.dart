import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:whats_app_clone/config/routing/app_routes.dart';
import 'package:whats_app_clone/config/themes/theme_manager.dart';

class WhatsApp extends StatelessWidget {
  const WhatsApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeManager themeManager = ThemeManager();

    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        themeManager.updateDynamicColors(
          lightDynamic: lightDynamic,
          darkDynamic: darkDynamic,
        );

        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeManager.themeNotifier,
          builder: (BuildContext context, ThemeMode value, Widget? child) {
            return GestureDetector(
              onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: themeManager.lightTheme,
                darkTheme: themeManager.darkTheme,
                themeMode: value,
                onGenerateRoute: generateRoutes,
                localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                  GlobalCupertinoLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: const <Locale>[Locale('ar')],
                locale: const Locale('ar'),
                home: Container(),
              ),
            );
          },
        );
      },
    );
  }
}
