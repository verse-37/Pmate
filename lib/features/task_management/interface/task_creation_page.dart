import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pmate/env/common/appbar.dart';
import 'package:pmate/env/common/snackbars.dart';
import 'package:pmate/features/task_management/business/task_provider.dart';
import 'package:pmate/features/task_management/models/task.dart';
import 'package:provider/provider.dart';

class TaskCreationPage extends StatefulWidget {
  const TaskCreationPage({super.key});

  @override
  State<TaskCreationPage> createState() => _TaskCreationPageState();
}

class _TaskCreationPageState extends State<TaskCreationPage> {
  final TextEditingController _taskName = TextEditingController();
  final TextEditingController _taskDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final taskProvider = context.watch<TaskProvider>();

    void onCancelPressed() {
      Navigator.pop(context);
    }

    void onSavePressed() {
      taskProvider.addTask(
        Task(
          title: _taskName.text.trim(),
          description: _taskDescription.text.trim(),
          createdAt: DateTime.now(),
        ),
      );

      PmateSnackbars(
        title: local.task_creation_success_message_title,
        message: local.task_creation_success_message_content,
        contentType: ContentType.success,
      ).showSnackbar(context);

      Navigator.pop(context);
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
          child: TaskCreationForm(
            taskName: _taskName,
            taskDescription: _taskDescription,
          ),
        ),
      ),
    );
  }
}

class TaskCreationForm extends StatefulWidget {
  const TaskCreationForm({
    super.key,
    required this.taskName,
    required this.taskDescription,
  });

  final TextEditingController taskName;
  final TextEditingController taskDescription;

  @override
  State<TaskCreationForm> createState() => _TaskCreationFormState();
}

class _TaskCreationFormState extends State<TaskCreationForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
            ),
            child: TextFormField(
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
                  validator: RequiredValidator(
                    errorText: local.task_creation_title_missing,
                  ).call,
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
