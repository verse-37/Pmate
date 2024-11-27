import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:pmate/features/task_management/models/task.dart';

class TaskProvider extends ChangeNotifier {
  final taskBox = Hive.box<List>(TaskBox.name);

  List<Task> taskList = [];

  void init() {
    if (!taskBox.containsKey(TaskBox.tasksKey)) {
      taskBox.put(TaskBox.tasksKey, []);
    } else {
      taskList = taskBox.get(TaskBox.tasksKey)!.cast<Task>();
    }
  }

  void addTask(Task task) {
    taskList.add(task);
    taskBox.put(TaskBox.tasksKey, taskList);
    notifyListeners();
  }

  void toggleTask(int index, bool isCompleted) {
    taskList[index].isCompleted = isCompleted;
    taskBox.put(TaskBox.tasksKey, taskList);
    notifyListeners();
  }

  void updateTask(Task task, int index) {
    taskList[index] = task;
    taskBox.put(TaskBox.tasksKey, taskList);
    notifyListeners();
  }

  void deleteTask(Task task) {
    taskList.remove(task);
    taskBox.put(TaskBox.tasksKey, taskList);
    notifyListeners();
  }

  void deleteTaskAt(int index) {
    taskList.removeAt(index);
    taskBox.put(TaskBox.tasksKey, taskList);
    notifyListeners();
  }

  void clearTasks() {
    taskList.clear();
    taskBox.put(TaskBox.tasksKey, taskList);
    notifyListeners();
  }

  @override
  void dispose() {
    taskBox.close();
    super.dispose();
  }
}
