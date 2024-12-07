import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_field_validator/form_field_validator.dart';

class TaskDetailTitleField extends StatelessWidget {
  const TaskDetailTitleField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
      ),
      child: TextFormField(
        validator: RequiredValidator(
          errorText: local.task_creation_title_missing,
        ).call,
        controller: controller,
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
    );
  }
}

class TaskDetailDescriptionField extends StatelessWidget {
  const TaskDetailDescriptionField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: local.task_notes_field,
        hintStyle: theme.textTheme.bodyMedium,
      ),
      maxLines: null, // Allow multiple lines
      keyboardType: TextInputType.multiline, // Show multiline keyboard
      textInputAction: TextInputAction.newline, // Enter key creates new line
    );
  }
}
