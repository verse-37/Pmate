import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/models/primitives.dart';
import 'package:pmate/features/task_management/models/task.dart';

class TaskDetailChecklistSection extends StatefulWidget {
  const TaskDetailChecklistSection({super.key, required this.task});

  final Task task;

  @override
  State<TaskDetailChecklistSection> createState() =>
      _TaskDetailChecklistSectionState();
}

class _TaskDetailChecklistSectionState
    extends State<TaskDetailChecklistSection> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ReorderableListView.builder(
      shrinkWrap: true,
      buildDefaultDragHandles: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.task.checkList.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex--;
          }
          final item = widget.task.checkList.removeAt(oldIndex);
          widget.task.checkList.insert(newIndex, item);
        });
      },
      itemBuilder: (context, i) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 5.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
              color: theme.colorScheme.primaryContainer,
            ),
            child: Row(
              children: [
                Checkbox.adaptive(
                  value: widget.task.checkList[i].second,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        widget.task.checkList[i].second = value;
                      });
                    }
                  },
                ),
                Text(widget.task.checkList[i].first),
                const Spacer(),
                ReorderableDragStartListener(
                  index: i,
                  child: const Icon(Icons.drag_indicator),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TaskDetailChecklistField extends StatefulWidget {
  const TaskDetailChecklistField({super.key, required this.task});

  final Task task;

  @override
  State<TaskDetailChecklistField> createState() =>
      _TaskDetailChecklistFieldState();
}

class _TaskDetailChecklistFieldState extends State<TaskDetailChecklistField> {
  late final TextEditingController newChecklistItem;

  @override
  void initState() {
    super.initState();
    newChecklistItem = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        color: theme.colorScheme.primaryContainer,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              if (newChecklistItem.text.isNotEmpty) {
                widget.task.checkList.add(
                  Pair(newChecklistItem.text, false),
                );
                newChecklistItem.clear();
              }
            },
            icon: const Icon(Icons.add),
          ),
          Expanded(
            child: TextField(
              controller: newChecklistItem,
              decoration: InputDecoration(
                hintText: local.task_checklist_item_placeholder,
                hintStyle: theme.textTheme.bodyMedium,
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
