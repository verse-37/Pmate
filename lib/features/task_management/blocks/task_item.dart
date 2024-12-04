import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pmate/env/models/primitives.dart';
import 'package:pmate/env/widgets/snackbars.dart';
import 'package:pmate/features/settings/business/task_settings_provider.dart';
import 'package:pmate/features/task_management/models/task.dart';
import 'package:provider/provider.dart';
import 'package:pmate/features/task_management/business/task_provider.dart';
import 'package:toastification/toastification.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<TaskSettingsProvider>();
    final taskProvider = context.watch<TaskProvider>();
    final task = taskProvider.taskList[index];
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final Pair<int, int> completedAndTotal = Pair(
      task.checkList.where((e) => e.second).length,
      task.checkList.length,
    );
    late final Widget rightGadget;

    void onDoneDragged(BuildContext context) {
      taskProvider.toggleTask(index, TaskStatus.completed);
      Slidable.of(context)?.close();
      //? This is a workaround to close the slidable after the task is toggled.
      PmateSnackbars(
        title: local.task_completed_congrats_title,
        message: local.task_completed_congrats_message,
      ).showToast(context: context, type: ToastificationType.success);
    }

    void onDeleteDragged(BuildContext context) {
      taskProvider.deleteTaskAt(index);
      Slidable.of(context)?.close();
    }

    final doneActionPane = ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: onDoneDragged,
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
          onPressed: onDeleteDragged,
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
