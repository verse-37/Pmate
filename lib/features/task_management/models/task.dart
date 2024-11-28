import 'package:hive/hive.dart';
import 'package:pmate/features/task_management/models/difficulty.dart';

part 'task.g.dart';
//?Command to generate the g.dart file: flutter pub run build_runner build. Since the command is deprecated, we need to use the following command instead: flutter pub run build_runner build --delete-conflicting-outputs

//? Change this after file is generated:
//? difficulty: Difficulty.values[fields[6] as int],
//? ..writeByte(6)
//? ..write(obj.difficulty.index);

class Task extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  bool isInProgress;

  @HiveField(5)
  List<String> checkList;

  @HiveField(6)
  Difficulty difficulty;

  Task({
    required this.title,
    required this.description,
    required this.isCompleted,
    this.isInProgress = false,
    this.checkList = const [],
    this.difficulty = Difficulty.easy,
  }) : createdAt = DateTime.now(); //? Set createdAt to now
}

class TaskBox {
  static const name = 'taskBox';
  static const tasksKey = 'tasks';
}
