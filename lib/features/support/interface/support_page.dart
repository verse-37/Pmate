import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pmate/env/models/pmate_page.dart';
import 'package:pmate/features/app/business/page_info_provider.dart';
import 'package:pmate/features/support/interface/subpages/bugs_and_fixes_page.dart';
import 'package:provider/provider.dart';

class SupportPage extends StatelessWidget implements PmatePage {
  const SupportPage({super.key});

  @override
  String get routeName => '/support';
  @override
  String get routePath => '/support';

  @override
  void init(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    context.read<PageInfoProvider>().setTitle(l10n.bug_and_fixes_title);
    context.read<PageInfoProvider>().setActions([]);
  }

  @override
  Widget build(BuildContext context) {
    init(context);

    final local = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text(local.support_page_contact_us),
              subtitle: Text(local.support_page_contact_us_message),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(const BugsAndFixesPage().routePath),
              style: ListTileStyle.drawer,
            ),
          ],
        ),
      ),
    );
  }
}
