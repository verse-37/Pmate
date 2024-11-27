import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/common/appbar.dart';
import 'package:pmate/env/common/primitives.dart';
import 'package:pmate/features/settings/interface/app_settings/appearance_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: PmateAppBar(title: local.settings),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSettings(
                name: local.settings_app,
                subpagesList: [
                  Triple(
                    local.settings_appearance,
                    Icons.color_lens,
                    AppearanceSettings(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppSettings extends StatelessWidget {
  const AppSettings({
    super.key,
    required this.name,
    required this.subpagesList,
  });

  final String name;
  final List<Triple<String, IconData, Widget>> subpagesList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name),
        ...subpagesList.map(
          (e) => SettingsSubpageDisplay(
            name: e.first,
            icon: e.second,
            subpage: e.third,
          ),
        ),
      ],
    );
  }
}

class SettingsSubpageDisplay extends StatelessWidget {
  const SettingsSubpageDisplay({
    super.key,
    required this.name,
    required this.icon,
    required this.subpage,
  });

  final String name;
  final IconData icon;
  final Widget subpage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => subpage,
        ),
      ),
      child: Container(
        color: theme.colorScheme.surface,
        child: Row(
          children: [
            Icon(icon),
            Text(name),
          ],
        ),
      ),
    );
  }
}
