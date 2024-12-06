import 'package:pmate/env/models/object_package.dart';
import 'package:pmate/env/models/pmate_model.dart';
import 'package:pmate/env/models/primitives.dart';

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

class Task extends PmateModel {
  //? Different from Java, here abstract classes can be implemented by classes.
  int? index;
  int? sectionIndex;
  String title;
  String description;
  TaskStatus status;
  DateTime createdAt;
  late List<Pair<String, bool>> checkList;
  Difficulty difficulty;
  List<String> tags;
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

  @override
  ObjectPackage toObjectPackage() {
    return ObjectPackage(
      intProperties: {
        'status': status.index,
        'difficulty': difficulty.index,
      },
      stringProperties: {
        'title': title,
        'description': description,
        'category': category ?? "",
        'createdAt': createdAt.toIso8601String(),
      },
      listStringProperties: {
        'checkListNames': checkList.map((e) => e.first).toList(),
        'tags': tags,
      },
      listBoolProperties: {
        'checkListCompletion': checkList.map((e) => e.second).toList(),
      },
    );
  }

  Task.fromObjectPackage(ObjectPackage package)
      : title = package.stringProperties['title'] ?? "",
        description = package.stringProperties['description'] ?? "",
        status = TaskStatus.values[package.intProperties['status'] ?? 0],
        createdAt = DateTime.parse(
          package.stringProperties['createdAt'] ??
              DateTime.now().toIso8601String(),
        ),
        checkList = List.generate(
          package.listStringProperties['checkListNames']?.length ?? 0,
          (index) => Pair(
            package.listStringProperties['checkListNames']![index],
            package.listBoolProperties['checkListCompletion']![index],
          ),
        ),
        difficulty =
            Difficulty.values[package.intProperties['difficulty'] ?? 0],
        tags = package.listStringProperties['tags'] ?? [],
        category = package.stringProperties['category'];

  Task copyWith({
    String? title,
    String? description,
    TaskStatus? status,
    DateTime? createdAt,
    List<Pair<String, bool>>? checkList,
    Difficulty? difficulty,
    List<String>? tags,
    String? category,
  }) =>
      Task(
        title: title ?? this.title,
        description: description ?? this.description,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        checkList: checkList ?? this.checkList,
        difficulty: difficulty ?? this.difficulty,
        tags: tags ?? this.tags,
        category: category ?? this.category,
      );
}

class TaskBox {
  static const name = 'tasksStorageBox';
  static const tasksKey = 'tasksList';
}

//?Command to generate the g.dart file: flutter (packages) pub run build_runner build. Since the command is deprecated, we need to use the following command instead: flutter pub run build_runner build --delete-conflicting-outputs

//? If file is not generated, run the following command: flutter pub run build_runner clean.

//? Change this after file is generated:
//? difficulty: Difficulty.values[fields[6] as int],
//? ..writeByte(6)
//? ..write(obj.difficulty.index);