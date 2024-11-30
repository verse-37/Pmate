import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'themes_settings_bundle.g.dart';

@HiveType(typeId: 1)
class ThemeSettingsBundle {
  @HiveField(0)
  int themeMode;

  ThemeMode get getThemeMode {
    switch (themeMode) {
      case 0:
        return ThemeMode.light;
      case 1:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  ThemeSettingsBundle({required this.themeMode});
}
