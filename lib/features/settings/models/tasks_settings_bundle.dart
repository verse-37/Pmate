import 'package:pmate/env/models/object_package.dart';
import 'package:pmate/env/models/pmate_model.dart';

class TaskSettingsBundle extends PmateModel {
  bool doneTaskOnLeftSwipe;

  TaskSettingsBundle.fromObjectPackage(ObjectPackage package)
      : doneTaskOnLeftSwipe =
            package.boolProperties['doneTaskOnLeftSwipe'] ?? true;

  @override
  ObjectPackage toObjectPackage() {
    return ObjectPackage(
      boolProperties: {
        'doneTaskOnLeftSwipe': doneTaskOnLeftSwipe,
      },
    );
  }
}
