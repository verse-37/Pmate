import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/features/app/business/page_info_provider.dart';
import 'package:provider/provider.dart';

class TaskTodayPage extends StatelessWidget {
  const TaskTodayPage({super.key});

  void init(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    context.read<PageInfoProvider>().setTitle(l10n.task_today_page_title);
    context.read<PageInfoProvider>().setActions([]);
  }

  @override
  Widget build(BuildContext context) {
    init(context);

    return const Placeholder();
  }
}
