import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pmate/env/widgets/appbar.dart';
import 'package:pmate/env/models/primitives.dart';
import 'package:pmate/features/home/interface/home_page.dart';
import 'package:pmate/features/support/interface/support_page.dart';
import 'package:pmate/features/task_management/interface/task_page.dart';
import 'package:pmate/features/user_authentication/business/auth_service.dart';

class NavigationCenter extends StatefulWidget {
  const NavigationCenter({super.key, this.initialPageIndex = 0});

  final int initialPageIndex;

  @override
  State<NavigationCenter> createState() => _NavigationCenterState();
}

class _NavigationCenterState extends State<NavigationCenter> {
  late int _selectedPageIndex;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.initialPageIndex;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final pages = <Triple<String, Widget, IconData>>[
      Triple(
        l10n.home_page_title,
        const HomePage(),
        Icons.home,
      ),
      Triple(
        l10n.task_page_title,
        const TaskPage(),
        Icons.task,
      ),
      Triple(
        l10n.support_page_title,
        const SupportPage(),
        Icons.help,
      ),
    ];

    void onNotificationPressed() {
      context.push('/notifications');
    }

    void onSettingsPressed() {
      context.push('/settings');
    }

    void onSignOutPressed() {
      AuthService().signOut(context: context);
    }

    return Scaffold(
      appBar: PmateAppBar(
        title: pages[_selectedPageIndex].first,
      ),
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 70,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      child: Icon(Icons.person, size: 40),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'User Name',
                          //TODO: Get user name from database
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          'user@example.com',
                          //TODO: Get user email from database
                          style: theme.textTheme.labelSmall,
                        ),
                      ],
                    ),
                    const Spacer(),
                    //? Spacer helps to push the buttons to the right
                    IconButton(
                      onPressed: onNotificationPressed,
                      //TODO: Create notification page
                      icon: const Icon(Icons.notifications),
                    ),
                    IconButton(
                      onPressed: onSettingsPressed,
                      //TODO: Create settings page
                      icon: const Icon(Icons.settings),
                    ),
                  ],
                ),
              ),
              ...List.generate(
                pages.length,
                (i) => ListTile(
                  selected: i == _selectedPageIndex,
                  title: Text(pages[i].first),
                  leading: Icon(pages[i].third),
                  onTap: () {
                    if (i != _selectedPageIndex) {
                      setState(() {
                        _selectedPageIndex = i;
                      });
                      context.pop();
                    }
                  },
                ),
              ),
              ListTile(
                title: Text(l10n.sign_out),
                leading: const Icon(Icons.logout),
                onTap: onSignOutPressed,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: pages[_selectedPageIndex].second,
      ),
    );
  }
}
