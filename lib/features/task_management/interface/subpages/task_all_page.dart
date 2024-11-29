import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/common/dividers.dart';
import 'package:pmate/features/task_management/business/task_provider.dart';
import 'package:pmate/features/task_management/interface/blocks/task_item.dart';
import 'package:pmate/features/task_management/interface/subpages/task_creation_page.dart';
import 'package:pmate/features/task_management/models/task.dart';
import 'package:provider/provider.dart';

class TaskAllPage extends StatelessWidget {
  const TaskAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final taskProvider = context.watch<TaskProvider>();
    final n = taskProvider.taskList.length;
    List<Task> inProgressTasks = [];
    List<Task> inCompletedTasks = [];
    List<Task> completedTasks = [];

    for (int i = 0; i < n; i++) {
      final task = taskProvider.taskList[i]..index = i;
      if (task.status == TaskStatus.inProgress) {
        inProgressTasks.add(task);
      } else if (task.status == TaskStatus.completed) {
        completedTasks.add(task);
      } else {
        inCompletedTasks.add(task);
      }
    }

    void onAddTaskPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TaskCreationPage(),
        ),
      );
    }

    void onTaskReorder(int oldIndex, int newIndex) {
      taskProvider.moveTask(oldIndex, newIndex);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: onAddTaskPressed,
        tooltip: local.task_action_button_tooltip,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DividerWithText(text: local.task_focus_section),
            ReorderableListView(
              shrinkWrap: true,
              //? If the scroll view does not shrink wrap, then the scroll view will expand to the maximum allowed size in the [scrollDirection]. If the scroll view has unbounded constraints in the [scrollDirection], then [shrinkWrap] must be true.
              physics: const NeverScrollableScrollPhysics(),
              onReorder: onTaskReorder,
              children: inProgressTasks
                  .map(
                    (task) => TaskItem(
                      key: ValueKey(task),
                      index: task.index!,
                    ),
                  )
                  .toList(),
            ),
            DividerWithText(text: local.task_all_section),
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: onTaskReorder,
              children: inCompletedTasks
                  .map(
                    (task) => TaskItem(
                      key: ValueKey(task),
                      index: task.index!,
                    ),
                  )
                  .toList(),
            ),
            DividerWithText(text: local.task_completed_section),
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: onTaskReorder,
              children: completedTasks
                  .map(
                    (task) => TaskItem(
                      key: ValueKey(task),
                      index: task.index!,
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
