import 'package:flutter/material.dart';
import 'package:pmate/env/models/pmate_page.dart';
import 'package:pmate/env/widgets/bottom_nav_bar.dart';
import 'package:pmate/env/models/primitives.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/features/task_management/interface/task_all_page.dart';
import 'package:pmate/features/task_management/interface/task_today_page.dart';

class TaskPage extends StatefulWidget implements PmatePage {
  @override
  String get routeName => '/task';

  @override
  String get routePath => '/task';

  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();

  @override
  void init(BuildContext context) {}
}

class _TaskPageState extends State<TaskPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    final List<Triple<IconData, String, Widget>> subpages = [
      Triple(
        Icons.today,
        local.task_today_page_title,
        const TaskTodayPage(),
      ),
      Triple(
        Icons.list,
        local.task_all_page_tooltip,
        const TaskAllPage(),
      ),
    ];

    return Scaffold(
      bottomNavigationBar: PmateBottomNavBar(
        subpages: subpages.map((e) => Pair(e.first, e.second)).toList(),
        onTabChange: (index) => setState(() => selectedIndex = index),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: subpages[selectedIndex].third,
        ),
      ),
    );
  }
}
