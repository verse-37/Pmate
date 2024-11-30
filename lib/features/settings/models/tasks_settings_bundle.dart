import 'package:hive/hive.dart';

part 'tasks_settings_bundle.g.dart';

@HiveType(typeId: 2)
class TaskSettingsBundle {
  @HiveField(0)
  bool doneTaskOnLeftSwipe;

  TaskSettingsBundle({required this.doneTaskOnLeftSwipe});
}
