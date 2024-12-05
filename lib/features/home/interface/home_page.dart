import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/models/pmate_page.dart';
import 'package:pmate/features/app/business/page_info_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget implements PmatePage {
  const HomePage({super.key});

  @override
  String get routeName => '/home';
  @override
  String get routePath => '/home';

  @override
  void init(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    context.read<PageInfoProvider>().setTitle(l10n.home_page_title);
    context.read<PageInfoProvider>().setActions([]);
  }

  @override
  Widget build(BuildContext context) {
    init(context);

    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);

    //TODO: Add home page content

    return Scaffold();
  }
}
