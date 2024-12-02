import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: unused_import
import 'package:logger/logger.dart';
import 'package:pmate/env/widgets/appbar.dart';
import 'package:pmate/env/models/primitives.dart';
import 'package:pmate/features/settings/interface/app_settings/appearance/appearance_settings.dart';
import 'package:pmate/features/settings/interface/feature_settings/task/task_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: PmateAppBar(title: local.settings),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: ListView(
            children: [
              SettingsCategoryDisplay(
                name: local.settings_app,
                subpagesList: [
                  Triple(
                    local.settings_appearance,
                    Icons.color_lens,
                    const AppearanceSettings(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SettingsCategoryDisplay(
                name: local.settings_feature,
                subpagesList: [
                  Triple(
                    local.settings_task_switches,
                    Icons.add_task,
                    const TaskSettings(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingsCategoryDisplay extends StatelessWidget {
  const SettingsCategoryDisplay({
    super.key,
    required this.name,
    required this.subpagesList,
  });

  final String name;
  final List<Triple<String, IconData, Widget>> subpagesList;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(name),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: subpagesList
                .map((e) => SettingsSubpageDisplay(
                      name: e.first,
                      icon: e.second,
                      subpage: e.third,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class SettingsSubpageDisplay extends StatelessWidget {
  const SettingsSubpageDisplay({
    super.key,
    required this.name,
    required this.icon,
    required this.subpage,
  });

  final String name;
  final IconData icon;
  final Widget subpage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      //? The issue (of not being able to tap on the blank space) occurs because by default, GestureDetector only detects gestures in areas where its child widget draws something (is hit-testable). Using either of these solutions will make the entire area respond to taps.
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => subpage,
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
            Icon(icon),
            const SizedBox(width: 15),
            Text(name),
          ],
        ),
      ),
    );
  }
}
