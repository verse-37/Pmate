import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:pmate/env/config/globals.dart';
import 'package:pmate/features/support/business/device_info.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/features/support/business/local_storage.dart';

class EmailSender {
  static Future<void> sendEmail(Email email) async {
    await FlutterEmailSender.send(email);
  }

  static Future<void> sendDebugEmail(BuildContext context) async {
    final local = AppLocalizations.of(context);
    final String deviceInfoString = DeviceInfo.deviceGenericInfo.entries
        .map((e) => '${e.key}: ${e.value}')
        .join('\n');

    final LocalStorage localStorage = LocalStorage();
    final String filename =
        "device_info_report_${DateTime.now().toIso8601String()}.txt";
    await localStorage.writeFile(filename, deviceInfoString,
        isPermanent: false);
    //Save the file to the cache directory.

    final Email email = Email(
      subject: local.bug_and_fixes_email_subject(Globals.appInfo.appName),
      body: local.bug_and_fixes_email_body,
      recipients: [Globals.emailSupportAddress],
      attachmentPaths: [
        (await localStorage.localFile(filename, isPermanent: false)).path
      ],
    );

    await FlutterEmailSender.send(email);
  }
}
