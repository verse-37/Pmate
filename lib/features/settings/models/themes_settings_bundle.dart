import 'package:hive/hive.dart';

part 'themes_settings_bundle.g.dart';

@HiveType(typeId: 1)
class ThemeSettingsBundle {
  @HiveField(0)
  int themeMode;

  ThemeSettingsBundle({required this.themeMode});
}

class SettingsBox {
  static const String themesBoxName = "themes";
  static const String themeModeKey = "themeMode";
}
