import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:pmate/env/constants/globals.dart';
import 'package:pmate/features/navigation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //? This function is not optimized for the web. See https://docs.flutter.dev/platform-integration/web/initialization#initializing-the-engine
  Globals.appInfo = await PackageInfo.fromPlatform();

  runApp(const PmateRoot());
}
