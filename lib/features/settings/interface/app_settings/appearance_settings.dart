import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pmate/env/common/appbar.dart';
import 'package:pmate/features/settings/business/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:logger/logger.dart';

class AppearanceSettings extends StatelessWidget {
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

class AppearanceSettingsTheme extends StatefulWidget {
  const AppearanceSettingsTheme({super.key});

  @override
  State<AppearanceSettingsTheme> createState() =>
      _AppearanceSettingsThemeState();
}

class _AppearanceSettingsThemeState extends State<AppearanceSettingsTheme> {
  int selectedThemeIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    final settingsProvider = context.watch<SettingsProvider>();

    selectedThemeIndex = settingsProvider.themeProvider.themeMode;

    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(local.settings_appearance_theme),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.hardEdge,
          //? clipBehavior is used to prevent the child's hard square edges from overflowing the parent
          child: Column(
            children: [
              GNav(
                backgroundColor: theme.colorScheme.surfaceContainerHigh,
                color: theme.colorScheme.onSurface,
                activeColor: theme.colorScheme.primary,
                tabBackgroundColor: theme.colorScheme.surfaceContainerHighest,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                tabMargin: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                gap: 8,
                //?gap is the space between the text and the icon
                tabs: [
                  GButton(
                    icon: Icons.light_mode,
                    text: local.settings_appearance_theme_light,
                  ),
                  GButton(
                    icon: Icons.dark_mode,
                    text: local.settings_appearance_theme_dark,
                  ),
                  GButton(
                    icon: Icons.phone_android,
                    text: local.settings_appearance_theme_system,
                  ),
                ],
                selectedIndex: selectedThemeIndex,
                onTabChange: (value) {
                  if (value != selectedThemeIndex) {
                    selectedThemeIndex = value;
                    settingsProvider.changeTheme(value);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
