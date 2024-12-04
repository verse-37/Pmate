import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: unused_import
import 'package:logger/logger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pmate/env/config/globals.dart';
import 'package:pmate/env/models/object_package.dart';
import 'package:pmate/features/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pmate/features/settings/business/appearance_settings_provider.dart';
import 'package:pmate/features/settings/business/task_settings_provider.dart';
import 'package:pmate/features/task_management/models/task.dart';
import 'env/config/apis/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Globals.appInfo = await PackageInfo.fromPlatform();

  final documentDirectory = await getApplicationDocumentsDirectory();

  Hive.initFlutter(documentDirectory.path);
  Hive.registerAdapter(ObjectPackageAdapter());

  await Hive.openBox<List>(
    TaskBox.name,
    path: documentDirectory.path,
  );
  await Hive.openBox<ObjectPackage>(
    AppearanceSettingsBox.themesBoxName,
    path: documentDirectory.path,
  );
  await Hive.openBox<ObjectPackage>(
    TasksSettingsBox.tasksBoxName,
    path: documentDirectory.path,
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runZonedGuarded(() {
    runApp(const PmateRoot());
  }, (error, stack) {
    // TODO: Handle error, maybe send to firebase crashlytics.
  });
}

//? The .fromPlatform() function is not optimized for the web. See https://docs.flutter.dev/platform-integration/web/initialization#initializing-the-engine
