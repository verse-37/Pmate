import 'package:flutter/material.dart';
import 'package:pmate/env/common/bottom_nav_bar.dart';
import 'package:pmate/env/common/primitives.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/features/task_management/interface/subpages/task_all_page.dart';
import 'package:pmate/features/task_management/interface/subpages/task_today_page.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    final List<Triple<IconData, String, Widget>> subpages = [
      Triple(Icons.home, local.task_today_page_title, const TaskTodayPage()),
      Triple(Icons.list, local.task_all_page_title, const TaskAllPage()),
    ];
    return Scaffold(
      bottomNavigationBar: PmateBottomNavBar(
        subpages: subpages.map((e) => Pair(e.first, e.second)).toList(),
      ),
      body: SafeArea(child: Container()),
    );
  }
}
