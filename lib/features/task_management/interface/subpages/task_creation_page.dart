import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/common/appbar.dart';

class TaskCreationPage extends StatelessWidget {
  const TaskCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PmateAppBar(title: local.task_creation_page_title),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 25.0,
            ),
            child: TaskCreationForm(),
          ),
        ),
      ),
    );
  }
}

class TaskCreationForm extends StatelessWidget {
  const TaskCreationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
