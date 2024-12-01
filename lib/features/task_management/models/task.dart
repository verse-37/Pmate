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
  //TODO: Completed tasks will be deleted after a certain period of time.
  //TODO: This can be changed in the settings.
}

class Task extends HiveObject {
  int? index;
  String title;
  String description;
  TaskStatus status;
  DateTime createdAt;
  late List<Pair<String, bool>> checkList;
  Difficulty difficulty;
  List<String>? tags;
  String? category;

  Task({
    required this.title,
    required this.description,
    this.status = TaskStatus.incomplete,
    required this.createdAt,
    this.checkList = const [],
    this.difficulty = Difficulty.easy,
    this.tags = const [],
    this.category,
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
      tags: tags,
      category: category,
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
        difficulty = Difficulty.values[communicator.difficulty],
        tags = communicator.tags,
        category = communicator.category;
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