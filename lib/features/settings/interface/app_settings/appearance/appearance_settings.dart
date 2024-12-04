import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/widgets/appbar.dart';
import 'package:pmate/features/settings/interface/app_settings/appearance/theme_settings.dart';
import 'package:logger/logger.dart';

class AppearanceSettings extends StatelessWidget {
  static const routeName = 'appearance';
  static const routePath = 'settings/appearance';

  const AppearanceSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    Logger().d(local.settings_appearance);

    return Scaffold(
      appBar: PmateAppBar(title: local.settings_appearance),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              AppearanceSettingsTheme(),
            ],
          ),
        ),
      ),
    );
  }
}
