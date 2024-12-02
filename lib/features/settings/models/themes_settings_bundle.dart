import 'package:flutter/material.dart';
import 'package:pmate/env/models/object_package.dart';
import 'package:pmate/env/models/pmate_model.dart';

class ThemeSettingsBundle extends PmateModel {
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

  ThemeSettingsBundle.fromObjectPackage(ObjectPackage package)
      : themeMode = package.intProperties['themeMode'] ?? 0;

  @override
  ObjectPackage toObjectPackage() {
    return ObjectPackage(
      intProperties: {
        'themeMode': themeMode,
      },
    );
  }
}
