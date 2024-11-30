import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pmate/features/settings/models/tasks_settings_bundle.dart';

class TasksSettingsBox {
  static const String tasksBoxName = "tasks";
  static const String doneTaskOnLeftSwipeKey = "doneTaskOnLeftSwipe";
}

class TaskSettingsProvider extends ChangeNotifier {
  final tasksBox = Hive.box<TaskSettingsBundle>(TasksSettingsBox.tasksBoxName);
  late TaskSettingsBundle bundle;

  void init() {
    if (!tasksBox.containsKey(TasksSettingsBox.doneTaskOnLeftSwipeKey)) {
      bundle = TaskSettingsBundle(
        doneTaskOnLeftSwipe: true,
      );
      tasksBox.put(TasksSettingsBox.doneTaskOnLeftSwipeKey, bundle);
    } else {
      bundle = tasksBox.get(TasksSettingsBox.doneTaskOnLeftSwipeKey)!;
    }
  }

  void changeDoneTaskOnLeftSwipe(bool doneTaskOnLeftSwipe) {
    bundle.doneTaskOnLeftSwipe = doneTaskOnLeftSwipe;
    tasksBox.put(TasksSettingsBox.doneTaskOnLeftSwipeKey, bundle);
    notifyListeners();
  }
}
