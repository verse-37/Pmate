import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/config/globals.dart';
import 'package:pmate/env/widgets/appbar.dart';
import 'package:pmate/features/support/business/device_info.dart';

class BugsAndFixesPage extends StatelessWidget {
  const BugsAndFixesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    void onEmailPressed() async {
      final String deviceInfoString = DeviceInfo.deviceGenericInfo.entries
          .map((e) => '${e.key}: ${e.value}')
          .join('\n');

      final Email email = Email(
        subject: local.bug_and_fixes_email_subject(Globals.appInfo.appName),
        body:
            "${local.bug_and_fixes_email_body}\n\n${local.bug_and_fixes_email_device_info}\n$deviceInfoString",
        recipients: [Globals.emailSupportAddress],
        attachmentPaths: [],
      );

      await FlutterEmailSender.send(email);
    }

    //TODO: Implement
    return Scaffold(
      appBar: PmateAppBar(title: local.bugs_and_fixes_page_title),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                local.bug_and_fixes_title,
                style: theme.textTheme.displayMedium,
              ),
              Text(
                local.bug_and_fixes_message,
                style: theme.textTheme.bodyMedium,
              ),
              ElevatedButton(
                onPressed: onEmailPressed,
                child: Text(local.bug_and_fixes_button),
              ),
              Text(
                local.bug_and_fixes_notes(Globals.emailSupportAddress),
                style: theme.textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
