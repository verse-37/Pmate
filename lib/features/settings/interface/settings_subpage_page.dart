import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:logger/logger.dart';
import 'package:pmate/features/settings/models/subpage_info.dart';

class SettingsSubpageDisplay extends StatelessWidget {
  const SettingsSubpageDisplay(
    this.page, {
    super.key,
  });

  final SubpageInfo page;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      //? The issue (of not being able to tap on the blank space) occurs because by default, GestureDetector only detects gestures in areas where its child widget draws something (is hit-testable). Using either of these solutions will make the entire area respond to taps.
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => page.page,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Row(
          children: [
            Icon(page.icon),
            const SizedBox(width: 15),
            Text(page.name),
          ],
        ),
      ),
    );
  }
}
