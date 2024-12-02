import 'package:hive/hive.dart';

part 'communicator.g.dart';

@HiveType(typeId: 3)
class Communicator extends HiveObject {
  @HiveField(0)
  Map<String, int> intProperties;
  @HiveField(1)
  Map<String, List<int>> listIntProperties;
  @HiveField(2)
  Map<String, String> stringProperties;
  @HiveField(3)
  Map<String, List<String>> listStringProperties;
  @HiveField(4)
  Map<String, bool> boolProperties;
  @HiveField(5)
  Map<String, List<bool>> listBoolProperties;
  @HiveField(6)
  Map<String, double> doubleProperties;
  @HiveField(7)
  Map<String, List<double>> listDoubleProperties;

  Communicator({
    required this.intProperties,
    required this.listIntProperties,
    required this.stringProperties,
    required this.listStringProperties,
    required this.boolProperties,
    required this.listBoolProperties,
    required this.doubleProperties,
    required this.listDoubleProperties,
  });
}
