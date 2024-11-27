import 'package:flutter/material.dart';
import 'package:pmate/env/common/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: PmateAppBar(title: local.notification_page_title),
      body: SafeArea(child: Container()),
    );
  }
}
