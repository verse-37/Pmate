import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pmate/env/widgets/dividers.dart';
import 'package:pmate/features/app/business/page_info_provider.dart';
import 'package:pmate/features/task_management/business/task_provider.dart';
import 'package:pmate/features/task_management/commons/task_item.dart';
import 'package:pmate/features/task_management/interface/task_detail_page.dart';
import 'package:pmate/features/task_management/models/task.dart';
import 'package:provider/provider.dart';

class TaskTodayPage extends StatefulWidget {
  const TaskTodayPage({super.key});

  @override
  State<TaskTodayPage> createState() => _TaskTodayPageState();
}

class _TaskTodayPageState extends State<TaskTodayPage> {
  bool editModeOn = false;

  void toggleEditMode(int listLength) {
    if (listLength < 2) {
      return;
    }
    setState(() {
      editModeOn = !editModeOn;
    });
  }

  void init(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final taskProvider = context.watch<TaskProvider>();
    context.read<PageInfoProvider>().setTitle(l10n.task_today_page_title);
    context.read<PageInfoProvider>().setActions([
      IconButton(
        onPressed: () => toggleEditMode(taskProvider.taskList.length),
        icon: editModeOn ? const Icon(Icons.check) : const Icon(Icons.edit),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    init(context);

    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final taskProvider = context.watch<TaskProvider>();
    final n = taskProvider.taskList.length;
    List<Task> inCompletedTasks = [];
    List<Task> inProgressTasks = [];

    for (int i = 0; i < n; i++) {
      final task = taskProvider.taskList[i]..index = i;
      if (task.status == TaskStatus.inProgress) {
        inProgressTasks.add(task..sectionIndex = inProgressTasks.length);
      } else if (task.status == TaskStatus.incomplete &&
          task.createdAt.day == DateTime.now().day &&
          task.createdAt.month == DateTime.now().month &&
          task.createdAt.year == DateTime.now().year) {
        inCompletedTasks.add(task..sectionIndex = inCompletedTasks.length);
      }
    }

    void onAddTaskPressed() {
      context.push(TaskDetailPage.routePath);
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
        child: Builder(builder: (context) {
          if (inCompletedTasks.isEmpty && inProgressTasks.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    local.task_all_no_task_title,
                    style: theme.textTheme.displaySmall,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    local.task_all_no_task_message,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              DividerWithText(text: local.task_focus_section),
              ReorderableListView(
                buildDefaultDragHandles: false,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                onReorder: onTaskReorder,
                children: inProgressTasks
                    .map(
                      (task) => TaskItem(
                        key: ValueKey(task),
                        listIndex: task.index!,
                        sectionIndex: task.sectionIndex!,
                        editModeOn: editModeOn,
                      ),
                    )
                    .toList(),
              ),
              DividerWithText(text: local.task_today_section),
              ReorderableListView(
                buildDefaultDragHandles: false,
                shrinkWrap: true,
                //? If the scroll view does not shrink wrap, then the scroll view will expand to the maximum allowed size in the [scrollDirection]. If the scroll view has unbounded constraints in the [scrollDirection], then [shrinkWrap] must be true.
                physics: const NeverScrollableScrollPhysics(),
                onReorder: onTaskReorder,
                children: inCompletedTasks
                    .map(
                      (task) => TaskItem(
                        key: ValueKey(task),
                        listIndex: task.index!,
                        sectionIndex: task.sectionIndex!,
                        editModeOn: editModeOn,
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        }),
      ),
    );
  }
}
