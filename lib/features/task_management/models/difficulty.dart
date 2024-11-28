import 'package:hive/hive.dart';

part 'difficulty.g.dart';

@HiveType(typeId: 2)
enum Difficulty {
  @HiveField(0)
  veryEasy,
  @HiveField(1)
  easy,
  @HiveField(2)
  medium,
  @HiveField(3)
  hard,
  @HiveField(4)
  veryHard,
}
