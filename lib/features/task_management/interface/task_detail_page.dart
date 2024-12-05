import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:pmate/env/widgets/appbar.dart';
import 'package:pmate/env/widgets/snackbars.dart';
import 'package:pmate/features/task_management/business/task_provider.dart';
import 'package:pmate/features/task_management/commons/difficulty_colors.dart';
import 'package:pmate/features/task_management/models/task.dart';
import 'package:provider/provider.dart';

class TaskDetailPage extends StatefulWidget {
  static const routeName = 'detail';
  static const routePath = '/task/detail';

  const TaskDetailPage({super.key, this.task, this.index});

  final Task? task;
  final int? index;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final TextEditingController _taskName = TextEditingController();
  final TextEditingController _taskDescription = TextEditingController();
  late final Task _task;

  @override
  void initState() {
    super.initState();
    _taskName.text = widget.task?.title ?? "";
    _taskDescription.text = widget.task?.description ?? "";
    _task = widget.task ??
        Task(
          title: "",
          description: "",
          createdAt: DateTime.now(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final taskProvider = context.watch<TaskProvider>();
    final formKey = GlobalKey<FormState>();

    void onSavePressed() {
      if (!formKey.currentState!.validate()) {
        return;
      }

      _task.title = _taskName.text.trim();
      _task.description = _taskDescription.text.trim();

      if (widget.task == null) {
        taskProvider.addTask(_task);

        PmateSnackbars(
          title: local.task_creation_success_message_title,
          message: local.task_creation_success_message_content,
        ).showSnackbar(context, ContentType.success);
      } else {
        taskProvider.updateTask(_task, widget.index!);
      }

      context.pop();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PmateAppBar(
        title: local.task_creation_page_title,
        actions: [
          TextButton(
            onPressed: onSavePressed,
            child: Text(
              local.save,
              style: theme.textTheme.displaySmall,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: TaskDetailFields(
            taskName: _taskName,
            taskDescription: _taskDescription,
            formKey: formKey,
            task: _task,
          ),
        ),
      ),
    );
  }
}

class TaskDetailFields extends StatefulWidget {
  const TaskDetailFields({
    super.key,
    required this.taskName,
    required this.taskDescription,
    required this.formKey,
    required this.task,
  });

  final TextEditingController taskName;
  final TextEditingController taskDescription;
  final GlobalKey<FormState> formKey;
  final Task task;

  @override
  State<TaskDetailFields> createState() => _TaskDetailFieldsState();
}

class _TaskDetailFieldsState extends State<TaskDetailFields> {
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
            ),
            child: TextFormField(
              validator: RequiredValidator(
                errorText: local.task_creation_title_missing,
              ).call,
              controller: widget.taskName,
              style: theme.textTheme.bodyLarge!.copyWith(fontSize: 24),
              minLines: 1,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: local.title,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.done,
              //Text input action is set to done to prevent the user from adding a new line. Text input action configure the action button on the keyboard.
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              top: 10.0,
            ),
            child: Column(
              children: [
                TextFormField(
                  controller: widget.taskDescription,
                  decoration: InputDecoration(
                    hintText: local.task_notes_field,
                    hintStyle: theme.textTheme.bodyMedium,
                  ),
                  maxLines: null, // Allow multiple lines
                  keyboardType:
                      TextInputType.multiline, // Show multiline keyboard
                  textInputAction:
                      TextInputAction.newline, // Enter key creates new line
                ),
                const SizedBox(height: 15),
                Text(
                  local.task_difficulty_section,
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 10),
                SizedBox(
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
                        backgroundColor:
                            DifficultyColors.difficultyColors[value],
                        indicatorColor: theme.colorScheme.onPrimaryContainer,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(local.task_difficulty_very_easy),
                    Text(local.task_difficulty_very_hard),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
