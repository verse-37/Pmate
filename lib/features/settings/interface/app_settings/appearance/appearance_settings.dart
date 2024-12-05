import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/models/pmate_page.dart';
import 'package:pmate/env/widgets/appbar.dart';
import 'package:pmate/features/app/business/page_info_provider.dart';
import 'package:pmate/features/settings/interface/app_settings/appearance/theme_settings.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class AppearanceSettings extends StatelessWidget implements PmatePage {
  @override
  String get routeName => 'appearance';
  @override
  String get routePath => 'settings/appearance';

  const AppearanceSettings({super.key});

  @override
  void init(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    context.read<PageInfoProvider>().setTitle(l10n.settings_appearance);
    context.read<PageInfoProvider>().setActions([]);
  }

  @override
  Widget build(BuildContext context) {
    init(context);

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
