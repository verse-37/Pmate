import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/common/primitives.dart';
import 'package:pmate/features/home/interface/home_page.dart';
import 'package:pmate/features/notifications/interface/notification_page.dart';
import 'package:pmate/features/settings/interface/settings.page.dart';
import 'package:pmate/features/task_management/interface/task_page.dart';

class NavigationCenter extends StatefulWidget {
  const NavigationCenter({super.key});

  @override
  State<NavigationCenter> createState() => _NavigationCenterState();
}

class _NavigationCenterState extends State<NavigationCenter> {
  int _selectedPageIndex = 0;

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
    ];

    void onNotificationPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NotificationPage()),
      );
    }

    void onSettingsPressed() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SettingsPage()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_selectedPageIndex].first),
        backgroundColor: theme.colorScheme.primaryContainer,
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
                          style: theme.textTheme.labelLarge,
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
              for (int i = 0; i < pages.length; i++)
                ListTile(
                  selected: i == _selectedPageIndex,
                  title: Text(pages[i].first),
                  leading: Icon(pages[i].third),
                  onTap: () {
                    if (i != _selectedPageIndex) {
                      setState(() {
                        _selectedPageIndex = i;
                      });
                      Navigator.pop(context);
                    }
                  },
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