import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: unused_import
import 'package:logger/logger.dart';
import 'package:pmate/env/models/pmate_page.dart';
import 'package:pmate/env/widgets/appbar.dart';
import 'package:pmate/features/app/business/page_info_provider.dart';
import 'package:pmate/features/settings/interface/app_settings/appearance/appearance_settings.dart';
import 'package:pmate/features/settings/interface/feature_settings/task/task_settings.dart';
import 'package:pmate/features/settings/interface/settings_category_widget.dart';
import 'package:pmate/features/settings/models/subpage_info.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget implements PmatePage {
  const SettingsPage({super.key});

  @override
  String get routeName => '/settings';
  @override
  String get routePath => '/settings';

  @override
  void init(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    context.read<PageInfoProvider>().setTitle(l10n.settings);
    context.read<PageInfoProvider>().setActions([]);
  }

  @override
  Widget build(BuildContext context) {
    init(context);

    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: PmateAppBar(title: local.settings),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: ListView(
            children: [
              SettingsCategoryDisplay(
                name: local.settings_app,
                subpagesList: [
                  SubpageInfo(
                    name: local.settings_appearance,
                    icon: Icons.color_lens,
                    route: '/settings/appearance',
                    page: const AppearanceSettings(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SettingsCategoryDisplay(
                name: local.settings_feature,
                subpagesList: [
                  SubpageInfo(
                    name: local.settings_task_switches,
                    icon: Icons.add_task,
                    route: '/settings/tasks',
                    page: const TaskSettings(),
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
