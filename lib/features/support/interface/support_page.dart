import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pmate/features/support/interface/subpages/bugs_and_fixes_page.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  static const routeName = '/support';
  static const routePath = '/support';

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              title: Text(local.support_page_contact_us),
              subtitle: Text(local.support_page_contact_us_message),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push(BugsAndFixesPage.routePath),
              style: ListTileStyle.drawer,
            ),
          ],
        ),
      ),
    );
  }
}
