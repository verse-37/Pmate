import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pmate/features/settings/models/themes_settings_bundle.dart';

class AppearanceSettingsBox {
  static const String themesBoxName = "themes";
  static const String themeModeKey = "themeMode";
}

class AppearanceSettingsProvider extends ChangeNotifier {
  final themesBox =
      Hive.box<ThemeSettingsBundle>(AppearanceSettingsBox.themesBoxName);
  late ThemeSettingsBundle bundle;

  void init() {
    if (!themesBox.containsKey(AppearanceSettingsBox.themeModeKey)) {
      bundle = ThemeSettingsBundle(themeMode: 0);
      themesBox.put(AppearanceSettingsBox.themeModeKey, bundle);
    } else {
      bundle = themesBox.get(AppearanceSettingsBox.themeModeKey)!;
    }
  }

  void changeTheme(int themeMode) {
    bundle.themeMode = themeMode;
    themesBox.put(AppearanceSettingsBox.themeModeKey, bundle);
    notifyListeners();
  }
}
