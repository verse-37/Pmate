import 'package:hive/hive.dart';

part 'object_package.g.dart';

@HiveType(typeId: 1)
class ObjectPackage extends HiveObject {
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

  ObjectPackage({
    this.intProperties = const {},
    this.listIntProperties = const {},
    this.stringProperties = const {},
    this.listStringProperties = const {},
    this.boolProperties = const {},
    this.listBoolProperties = const {},
    this.doubleProperties = const {},
    this.listDoubleProperties = const {},
  });
}
