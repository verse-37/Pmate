import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pmate/features/settings/business/task_settings_provider.dart';
import 'package:pmate/features/task_management/models/task.dart';
import 'package:provider/provider.dart';
import 'package:pmate/features/task_management/business/task_provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<TaskSettingsProvider>();
    final taskProvider = context.watch<TaskProvider>();
    final task = taskProvider.taskList[index];
    final theme = Theme.of(context);
    final percentCompleted =
        task.checkList.where((e) => e.second).length.toDouble() /
            task.checkList.length;
    late final Widget rightGadget;

    final doneActionPane = ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {
            taskProvider.toggleTask(index, TaskStatus.completed);
          },
          icon: Icons.check,
          backgroundColor: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );

    final deleteActionPane = ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {
            taskProvider.deleteTaskAt(index);
          },
          icon: Icons.delete,
          backgroundColor: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );

    if 

    //TODO: Add a window "Task Detail" when clicking on the task item.
    //TODO: Add a window "Task Completion" when clicking on the circular percent indicator.
    //TODO: Add slidable action, complete for swipe right, delete for swipe left.
    //TODO: New setting for switch the two action panes.

    return Slidable(
      startActionPane: settingsProvider.bundle.doneTaskOnLeftSwipe
          ? doneActionPane
          : deleteActionPane,
      endActionPane: settingsProvider.bundle.doneTaskOnLeftSwipe
          ? deleteActionPane
          : doneActionPane,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(task.title),
                  ],
                ),
              ),
              if (task.checkList.isNotEmpty)
                CircularPercentIndicator(
                  radius: 40,
                lineWidth: 10,
                animation: true,
                animationDuration: 500,
                percent: percentCompleted,
                center: Text(
                  percentCompleted.toStringAsFixed(2),
                ),
                progressColor: theme.colorScheme.primary,
                //TODO: the color of the indicator should be the color of the task's category.
                circularStrokeCap: CircularStrokeCap.round,
              ),
              if (task.checkList.isEmpty)
                Checkbox(
                  value: task.status == TaskStatus.completed,
                  onChanged: (value) {
                    taskProvider.toggleTask(index, TaskStatus.completed);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
