import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pmate/env/common/globals.dart';
import 'package:pmate/features/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pmate/features/settings/models/themes_settings_bundle.dart';
import 'package:pmate/features/task_management/models/task.dart';
import 'package:pmate/features/task_management/models/task_communicator.dart';
import 'env/config/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Globals.appInfo = await PackageInfo.fromPlatform();

  await Hive.initFlutter();
  Hive.registerAdapter(TaskCommunicatorAdapter());
  Hive.registerAdapter(ThemeSettingsBundleAdapter());
  await Hive.openBox<List>(TaskBox.name);
  await Hive.openBox<ThemeSettingsBundle>(SettingsBox.themesBoxName);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const PmateRoot());
}

  //? The .fromPlatform() function is not optimized for the web. See https://docs.flutter.dev/platform-integration/web/initialization#initializing-the-engine
