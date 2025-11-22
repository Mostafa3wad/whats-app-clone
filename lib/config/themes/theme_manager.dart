import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class ThemeManager {
  final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier<ThemeMode>(
    ThemeMode.system,
  );
  late ColorScheme lightColorScheme;
  late ColorScheme darkColorScheme;

  ThemeManager({ColorScheme? lightDynamic, ColorScheme? darkDynamic}) {
    _initializeColorSchemes(
      lightDynamic: lightDynamic,
      darkDynamic: darkDynamic,
    );
  }

  void _initializeColorSchemes({
    ColorScheme? lightDynamic,
    ColorScheme? darkDynamic,
  }) {
    if (lightDynamic != null && darkDynamic != null) {
      lightColorScheme = lightDynamic.harmonized();
      darkColorScheme = darkDynamic.harmonized();
    } else {
      lightColorScheme = ColorScheme.fromSeed(seedColor: AppColors.brandColor);
      darkColorScheme = ColorScheme.fromSeed(
        seedColor: AppColors.brandColor,
        brightness: Brightness.dark,
      );
    }
  }

  void updateDynamicColors({
    ColorScheme? lightDynamic,
    ColorScheme? darkDynamic,
  }) {
    _initializeColorSchemes(
      lightDynamic: lightDynamic,
      darkDynamic: darkDynamic,
    );
  }

  ThemeData get lightTheme => ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 18,
        color: lightColorScheme.onSurface,
        fontWeight: FontWeight.bold,
        fontFamily: 'Rubik',
      ),
    ),
    fontFamily: 'Rubik',
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: lightColorScheme.surface,
    ),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
  );

  ThemeData get darkTheme => ThemeData(
    useMaterial3: true,
    colorScheme: darkColorScheme,
    brightness: Brightness.dark,
    fontFamily: 'Rubik',
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: darkColorScheme.surface,
    ),
    cardTheme: CardThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
    ),
  );
}
