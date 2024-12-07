import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/features/task_management/models/task.dart';

class TaskDetailExpandableSection extends StatefulWidget {
  const TaskDetailExpandableSection({super.key, required this.task});

  final Task task;

  @override
  State<TaskDetailExpandableSection> createState() =>
      _TaskDetailExpandableSectionState();
}

class _TaskDetailExpandableSectionState
    extends State<TaskDetailExpandableSection> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          this.isExpanded = !this.isExpanded;
        });
      },
      children: [
        ExpansionPanel(
          isExpanded: isExpanded,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(local.task_detail_section),
            );
          },
          body: Column(
            children: [
              ListTile(
                title: Text(local.task_detail_created_at),
                subtitle: Text(widget.task.createdAt.toString()),
              ),
              ListTile(
                title: Text(local.task_detail_status),
                subtitle: Text(
                  local.task_status_name("${widget.task.status.index}"),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
