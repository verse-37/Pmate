import 'package:hive/hive.dart';

part 'task_communicator.g.dart';

@HiveType(typeId: 0)
class TaskCommunicator extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String description;

  @HiveField(3)
  String createdAt;

  @HiveField(4)
  int status;

  @HiveField(5)
  List<String> checkListNames;

  @HiveField(6)
  List<bool> checkListCompletion;

  @HiveField(7)
  int difficulty;

  @HiveField(8)
  List<String>? tags;

  @HiveField(9)
  String? category;

  TaskCommunicator({
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.checkListNames,
    required this.checkListCompletion,
    required this.difficulty,
    required this.tags,
    required this.category,
  });
}
