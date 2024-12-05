import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/models/pmate_page.dart';
import 'package:pmate/env/widgets/appbar.dart';
import 'package:pmate/features/app/business/page_info_provider.dart';
import 'package:pmate/features/settings/interface/feature_settings/task/task_gesture_settings.dart';
import 'package:provider/provider.dart';

class TaskSettings extends StatelessWidget implements PmatePage {
  const TaskSettings({super.key});

  @override
  String get routeName => 'task';
  @override
  String get routePath => 'settings/task';

  @override
  void init(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    context.read<PageInfoProvider>().setTitle(l10n.settings_task_switches);
    context.read<PageInfoProvider>().setActions([]);
  }

  @override
  Widget build(BuildContext context) {
    init(context);
    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: PmateAppBar(title: local.settings_task_switches),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TaskGestureSettings(),
            ],
          ),
        ),
      ),
    );
  }
}
