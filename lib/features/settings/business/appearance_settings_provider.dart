import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pmate/env/models/object_package.dart';
import 'package:pmate/features/settings/models/themes_settings_bundle.dart';

class AppearanceSettingsBox {
  static const String themesBoxName = "themes";
  static const String themeModeKey = "themeMode";
}

class AppearanceSettingsProvider extends ChangeNotifier {
  final themesBox =
      Hive.box<ObjectPackage>(AppearanceSettingsBox.themesBoxName);
  late ThemeSettingsBundle bundle;

  void init() {
    if (!themesBox.containsKey(AppearanceSettingsBox.themeModeKey)) {
      bundle = ThemeSettingsBundle.fromObjectPackage(ObjectPackage());
      themesBox.put(
          AppearanceSettingsBox.themeModeKey, bundle.toObjectPackage());
    } else {
      bundle = ThemeSettingsBundle.fromObjectPackage(
          themesBox.get(AppearanceSettingsBox.themeModeKey)!);
    }
  }

  void changeTheme(int themeMode) {
    bundle.themeMode = themeMode;
    themesBox.put(
      AppearanceSettingsBox.themeModeKey,
      bundle.toObjectPackage(),
    );
    notifyListeners();
  }
}
