import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/common/primitives.dart';
import 'package:pmate/features/settings/interface/app_settings/appearance_settings.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          local.settings,
          style: theme.textTheme.displaySmall,
        ),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [AppSettings()],
          ),
        ),
      ),
    );
  }
}

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    final name = local.settings_app;
    final Pair<String, Widget> appearance =
        Pair(local.settings_appearance, AppearanceSettings());

    return Column(
      children: [],
    );
  }
}
