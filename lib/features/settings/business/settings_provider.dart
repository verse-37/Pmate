import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pmate/features/settings/models/themes_settings_bundle.dart';

class SettingsProvider extends ChangeNotifier {
  final themesBox = Hive.box<ThemeSettingsBundle>(SettingsBox.themesBoxName);
  late ThemeSettingsBundle themeProvider;

  void init() {
    if (!themesBox.containsKey(SettingsBox.themeModeKey)) {
      themeProvider = ThemeSettingsBundle(themeMode: 0);
      themesBox.put(SettingsBox.themeModeKey, themeProvider);
    } else {
      themeProvider = themesBox.get(SettingsBox.themeModeKey)!;
    }
  }

  void changeTheme(int themeMode) {
    themeProvider.themeMode = themeMode;
    themesBox.put(SettingsBox.themeModeKey, themeProvider);
    notifyListeners();
  }
}
