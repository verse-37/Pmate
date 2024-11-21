import 'package:flutter/material.dart';
import 'package:pmate/env/constants.dart';
import 'package:pmate/features/welcome/welcome_page.dart';

class PmateRoot extends StatefulWidget {
  const PmateRoot({super.key});

  @override
  State<PmateRoot> createState() => _PmateRootState();
}

class _PmateRootState extends State<PmateRoot> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Globals.appInfo.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}
