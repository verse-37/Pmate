import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pmate/env/common/globals.dart';
import 'package:pmate/features/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'env/config/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Globals.appInfo = await PackageInfo.fromPlatform();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const PmateRoot());
}

  //? The .fromPlatform() function is not optimized for the web. See https://docs.flutter.dev/platform-integration/web/initialization#initializing-the-engine