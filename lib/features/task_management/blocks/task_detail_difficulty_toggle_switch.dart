import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:pmate/features/task_management/commons/difficulty_colors.dart';
import 'package:pmate/features/task_management/models/task.dart';

class TaskDetailDifficultyToggleSwitch extends StatefulWidget {
  const TaskDetailDifficultyToggleSwitch({super.key, required this.task});

  final Task task;

  @override
  State<TaskDetailDifficultyToggleSwitch> createState() =>
      _TaskDetailDifficultyToggleSwitchState();
}

class _TaskDetailDifficultyToggleSwitchState
    extends State<TaskDetailDifficultyToggleSwitch> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      //? The SizedBox is used to make the toggle switch take the full width of the screen.
      child: AnimatedToggleSwitch<int>.size(
        height: 40,
        borderWidth: 0,
        current: widget.task.difficulty.index,
        values: [0, 1, 2, 3, 4],
        onChanged: (value) {
          setState(() {
            widget.task.difficulty = Difficulty.values[value];
          });
        },
        styleBuilder: (value) {
          return ToggleStyle(
            backgroundColor: DifficultyColors.difficultyColors[value],
            indicatorColor: theme.colorScheme.onPrimaryContainer,
          );
        },
      ),
    );
  }
}
