import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/config/globals.dart';
import 'package:pmate/env/models/pmate_page.dart';
import 'package:pmate/env/widgets/appbar.dart';
import 'package:pmate/features/app/business/page_info_provider.dart';
import 'package:pmate/features/support/business/email_sender.dart';
import 'package:provider/provider.dart';

class BugsAndFixesPage extends StatelessWidget implements PmatePage {
  const BugsAndFixesPage({super.key});

  @override
  String get routeName => 'bugsandfixes';
  @override
  String get routePath => '/support/bugsandfixes';

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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: PmateAppBar(title: local.bugs_and_fixes_page_title),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  local.bug_and_fixes_title,
                  style: theme.textTheme.displaySmall,
                ),
                const SizedBox(height: 15),
                Text(
                  local.bug_and_fixes_message(Globals.emailSupportAddress),
                  style: theme.textTheme.bodyMedium,
                ),
                if (defaultTargetPlatform == TargetPlatform.android ||
                    defaultTargetPlatform == TargetPlatform.iOS) ...[
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () => EmailSender.sendDebugEmail(context),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: Text(
                      local.bug_and_fixes_button,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    local.bug_and_fixes_notes,
                    style: theme.textTheme.bodySmall,
                  ),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
