import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pmate/env/models/object_package.dart';
import 'package:pmate/features/settings/models/tasks_settings_bundle.dart';

class TasksSettingsBox {
  static const String tasksBoxName = "tasks";
  static const String tasksBoxKey = "tasksSettings";
}

class TaskSettingsProvider extends ChangeNotifier {
  final tasksBox = Hive.box<ObjectPackage>(TasksSettingsBox.tasksBoxName);
  late TaskSettingsBundle bundle;

  void init() {
    if (!tasksBox.containsKey(TasksSettingsBox.tasksBoxKey)) {
      bundle = TaskSettingsBundle.fromObjectPackage(ObjectPackage());
      tasksBox.put(TasksSettingsBox.tasksBoxKey, bundle.toObjectPackage());
    } else {
      bundle = TaskSettingsBundle.fromObjectPackage(
          tasksBox.get(TasksSettingsBox.tasksBoxKey)!);
    }
  }

  void changeDoneTaskOnLeftSwipe(bool doneTaskOnLeftSwipe) {
    bundle.doneTaskOnLeftSwipe = doneTaskOnLeftSwipe;
    tasksBox.put(
      TasksSettingsBox.tasksBoxKey,
      bundle.toObjectPackage(),
    );
    notifyListeners();
  }
}
