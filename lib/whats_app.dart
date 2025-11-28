import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whats_app_clone/config/routing/app_routes.dart';
import 'package:whats_app_clone/config/themes/theme_manager.dart';
import 'package:whats_app_clone/features/home/presentation/pages/home_page.dart';

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
              child: ScreenUtilInit(
                designSize: const Size(375, 812),
                minTextAdapt: true,
                splitScreenMode: true,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: themeManager.lightTheme,
                  darkTheme: themeManager.darkTheme,
                  themeMode: value,
                  onGenerateRoute: generateRoutes,
                  localizationsDelegates:
                      const <LocalizationsDelegate<dynamic>>[
                        GlobalCupertinoLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                  supportedLocales: const <Locale>[Locale('en')],
                  locale: const Locale('en'),
                  home: const HomePage(),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
