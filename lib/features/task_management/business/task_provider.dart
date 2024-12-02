import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pmate/env/models/object_package.dart';
import 'package:pmate/features/task_management/models/task.dart';

class TaskProvider extends ChangeNotifier {
  final taskBox = Hive.box<List>(TaskBox.name);

  List<Task> taskList = [];

  void init() {
    if (!taskBox.containsKey(TaskBox.tasksKey)) {
      taskBox.put(TaskBox.tasksKey, []);
    } else {
      taskList = taskBox
          .get(TaskBox.tasksKey)!
          .cast<ObjectPackage>()
          .map((e) => Task.fromObjectPackage(e))
          .toList();
    }
  }

  void update() {
    taskBox.put(
      TaskBox.tasksKey,
      taskList.map((e) => e.toObjectPackage()).toList(),
    );
    notifyListeners();
  }

  void addTask(Task task) {
    taskList.add(task);
    update();
  }

  void toggleTask(int index, TaskStatus status) {
    taskList[index].status = status;
    update();
  }

  void updateTask(Task task, int index) {
    taskList[index] = task;
    update();
  }

  void moveTask(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex--;
      //? If the task is moved to a higher index, decrement the new index
    }
    final task = taskList.removeAt(oldIndex);
    taskList.insert(newIndex, task);
    update();
  }

  void deleteTask(Task task) {
    taskList.remove(task);
    update();
  }

  void deleteTaskAt(int index) {
    taskList.removeAt(index);
    update();
  }

  void clearTasks() {
    taskList.clear();
    update();
  }

  @override
  void dispose() {
    taskBox.close();
    super.dispose();
  }
}
