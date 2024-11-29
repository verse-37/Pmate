import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pmate/features/task_management/models/task.dart';
import 'package:provider/provider.dart';
import 'package:pmate/features/task_management/business/task_provider.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final taskProvider = context.watch<TaskProvider>();
    final task = taskProvider.taskList[index];
    final percentCompleted =
        task.checkList.where((e) => e.second).length.toDouble() /
            task.checkList.length;

    final doneActionPane = ActionPane(
      motion: const ScrollMotion(),
      children: [
        SlidableAction(
          onPressed: (context) {
            taskProvider.toggleTask(index, TaskStatus.completed);
          },
          icon: Icons.check,
          backgroundColor: Theme.of(context).colorScheme.primary,
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
        ),
      ],
    );
    //TODO: Add a window "Task Detail" when clicking on the task item.
    //TODO: Add a window "Task Completion" when clicking on the circular percent indicator.
    //TODO: Add slidable action, complete for swipe right, delete for swipe left.
    //TODO: New setting for switch the two action panes.

    return Slidable(
      startActionPane: doneActionPane,
      endActionPane: deleteActionPane,
      child: Card(
        child: Row(
          children: [
            Column(
              children: [
                Text(task.title),
              ],
            ),
            CircularPercentIndicator(
              radius: 100,
              lineWidth: 10,
              animation: true,
              animationDuration: 500,
              percent: percentCompleted,
              center: Text(
                percentCompleted.toStringAsFixed(2),
              ),
              progressColor: Theme.of(context).colorScheme.primary,
              circularStrokeCap: CircularStrokeCap.round,
            ),
          ],
        ),
      ),
    );
  }
}
