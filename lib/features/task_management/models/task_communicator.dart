import 'package:hive/hive.dart';

part 'task_communicator.g.dart';

@HiveType(typeId: 0)
class TaskCommunicator extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  String createdAt;

  @HiveField(4)
  bool isInProgress;

  @HiveField(5)
  List<String> checkListNames;

  @HiveField(6)
  List<bool> checkListCompletion;

  @HiveField(7)
  int difficulty;

  TaskCommunicator({
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
    required this.isInProgress,
    required this.checkListNames,
    required this.checkListCompletion,
    required this.difficulty,
  });
}
