import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/common/dividers.dart';
import 'package:pmate/features/task_management/business/task_provider.dart';
import 'package:pmate/features/task_management/interface/subpages/task_creation_page.dart';
import 'package:pmate/features/task_management/models/task.dart';
import 'package:provider/provider.dart';

class TaskAllPage extends StatelessWidget {
  const TaskAllPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final taskProvider = context.watch<TaskProvider>();

    void onAddTaskPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TaskCreationPage(),
        ),
      );
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
              onReorder: (oldIndex, newIndex) {
                taskProvider.moveTask(oldIndex, newIndex);
              },
              children: taskProvider.taskList
                  .where((e) => e.isInProgress)
                  .map((e) => TaskItem(
                        key: ValueKey(e),
                        //? The key is used to identify the item in the list. This is used and REQUIRED by [ReorderableListView] to track the item's position.
                        task: e,
                      ))
                  .toList(),
            ),
            DividerWithText(text: local.task_all_section),
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: (oldIndex, newIndex) {
                taskProvider.moveTask(oldIndex, newIndex);
              },
              children: taskProvider.taskList
                  .where((e) => !e.isInProgress)
                  .map((e) => TaskItem(
                        key: ValueKey(e),
                        task: e,
                      ))
                  .toList(),
            ),
            DividerWithText(text: local.task_completed_section),
            ReorderableListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              onReorder: (oldIndex, newIndex) {
                taskProvider.moveTask(oldIndex, newIndex);
              },
              children: taskProvider.taskList
                  .where((e) => e.isCompleted)
                  .map((e) => TaskItem(
                        key: ValueKey(e),
                        task: e,
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
