import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pmate/env/models/primitives.dart';
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
    final Pair<int, int> completedAndTotal = Pair(
      task.checkList.where((e) => e.second).length,
      task.checkList.length,
    );
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

    if (task.checkList.isEmpty) {
      rightGadget = Checkbox(
        value: task.status == TaskStatus.completed,
        onChanged: (value) {
          taskProvider.toggleTask(
            index,
            value! ? TaskStatus.completed : TaskStatus.incomplete,
          );
        },
      );
    } else {
      rightGadget = CircularPercentIndicator(
        radius: 40,
        lineWidth: 10,
        animation: true,
        animationDuration: 500,
        percent: completedAndTotal.first.toDouble() / completedAndTotal.second,
        center: Text(
          "${completedAndTotal.first} / ${completedAndTotal.second}",
        ),
        progressColor: theme.colorScheme.primary,
        //TODO: the color of the indicator should be the color of the task's category.
        circularStrokeCap: CircularStrokeCap.round,
      );
    }

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
              rightGadget,
            ],
          ),
        ),
      ),
    );
  }
}
