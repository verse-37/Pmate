import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/widgets/appbar.dart';
import 'package:pmate/features/settings/interface/feature_settings/task/task_gesture_settings.dart';

class TaskSettings extends StatelessWidget {
  const TaskSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: PmateAppBar(title: local.settings_task_switches),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TaskGestureSettings(),
            ],
          ),
        ),
      ),
    );
  }
}
