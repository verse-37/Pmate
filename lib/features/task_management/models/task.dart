import 'package:hive/hive.dart';

part 'task.g.dart';
//?Command to generate the g.dart file: flutter pub run build_runner build

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.isCompleted,
  });
}

class TaskBox {
  static const name = 'taskBox';
  static const tasksKey = 'tasks';
}
