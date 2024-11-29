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

enum TaskStatus {
  incomplete,
  inProgress,
  completed,
}

class Task extends HiveObject {
  int? index;
  String title;
  String description;
  TaskStatus status;
  DateTime createdAt;
  late List<Pair<String, bool>> checkList;
  Difficulty difficulty;

  Task({
    required this.title,
    required this.description,
    this.status = TaskStatus.incomplete,
    required this.createdAt,
    this.checkList = const [],
    this.difficulty = Difficulty.easy,
  });

  TaskCommunicator toCommunicator() {
    return TaskCommunicator(
      title: title,
      description: description,
      status: status.index,
      createdAt: createdAt.toIso8601String(),
      checkListNames: checkList.map((e) => e.first).toList(),
      checkListCompletion: checkList.map((e) => e.second).toList(),
      difficulty: difficulty.index,
    );
  }

  Task.fromCommunicator(TaskCommunicator communicator)
      : title = communicator.title,
        description = communicator.description,
        status = TaskStatus.values[communicator.status],
        createdAt = DateTime.parse(communicator.createdAt),
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

//?Command to generate the g.dart file: flutter (packages) pub run build_runner build. Since the command is deprecated, we need to use the following command instead: flutter pub run build_runner build --delete-conflicting-outputs

//? If file is not generated, run the following command: flutter pub run build_runner clean.

//? Change this after file is generated:
//? difficulty: Difficulty.values[fields[6] as int],
//? ..writeByte(6)
//? ..write(obj.difficulty.index);