import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/features/settings/business/task_settings_provider.dart';
import 'package:provider/provider.dart';

class TaskGestureSettings extends StatefulWidget {
  const TaskGestureSettings({super.key});

  @override
  State<TaskGestureSettings> createState() => _TaskGestureSettingsState();
}

class _TaskGestureSettingsState extends State<TaskGestureSettings> {
  bool doneTaskOnLeftSwipe = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    final settingsProvider = context.watch<TaskSettingsProvider>();

    doneTaskOnLeftSwipe = settingsProvider.bundle.doneTaskOnLeftSwipe;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(local.settings_task_task_completion_gesture),
        ),
        const SizedBox(height: 10),
        AnimatedToggleSwitch.dual(
          current: doneTaskOnLeftSwipe,
          first: true, //Influence the value of the toggle switch
          second: false,
          spacing: MediaQuery.of(context).size.width - 120,
          style: ToggleStyle(
            borderColor: Colors.transparent,
            backgroundColor: theme.colorScheme.primaryContainer,
            indicatorColor: theme.colorScheme.primary,
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.surfaceContainerLow,
                blurRadius: 2,
                spreadRadius: 1,
                offset: const Offset(0, 1.5),
              ),
            ],
          ),
          onChanged: (value) {
            settingsProvider.changeDoneTaskOnLeftSwipe(value);
          },
          iconBuilder: (value) => Icon(
            value ? Icons.arrow_forward : Icons.arrow_back,
            color: theme.colorScheme.onPrimary,
          ),
          textBuilder: (value) => Text(
            value ? local.settings_left_to_right : local.settings_right_to_left,
          ),
        ),
      ],
    );
  }
}
