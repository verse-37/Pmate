import 'package:hive/hive.dart';
import 'package:pmate/env/common/primitives.dart';
import 'package:pmate/features/task_management/models/task_communicator.dart';

enum Difficulty {
  veryEasy,
  easy,
  medium,
  hard,
  veryHard,
}

class Task extends HiveObject {
  String title;
  String description;
  bool isCompleted;
  DateTime createdAt;
  bool isInProgress;
  late List<Pair<String, bool>> checkList;
  Difficulty difficulty;

  Task({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    this.isInProgress = false,
    this.checkList = const [],
    this.difficulty = Difficulty.easy,
  });

  TaskCommunicator toCommunicator() {
    return TaskCommunicator(
      title: title,
      description: description,
      isCompleted: isCompleted,
      createdAt: createdAt.toIso8601String(),
      isInProgress: isInProgress,
      checkListNames: checkList.map((e) => e.first).toList(),
      checkListCompletion: checkList.map((e) => e.second).toList(),
      difficulty: difficulty.index,
    );
  }

  Task.fromCommunicator(TaskCommunicator communicator)
      : title = communicator.title,
        description = communicator.description,
        isCompleted = communicator.isCompleted,
        createdAt = DateTime.parse(communicator.createdAt),
        isInProgress = communicator.isInProgress,
        checkList = List.generate(
          communicator.checkListNames.length,
          (index) => Pair(
            communicator.checkListNames[index],
            communicator.checkListCompletion[index],
          ),
        ),
        difficulty = Difficulty.values[communicator.difficulty];
}

class TaskBox {
  static const name = 'taskBox';
  static const tasksKey = 'tasks';
}

//?Command to generate the g.dart file: flutter pub run build_runner build. Since the command is deprecated, we need to use the following command instead: flutter pub run build_runner build --delete-conflicting-outputs

//? If file is not generated, run the following command: flutter pub run build_runner clean.

//? Change this after file is generated:
//? difficulty: Difficulty.values[fields[6] as int],
//? ..writeByte(6)
//? ..write(obj.difficulty.index);