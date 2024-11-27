import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/common/appbar.dart';

class BugsAndFixesPage extends StatelessWidget {
  const BugsAndFixesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    //TODO: Implement
    return Scaffold(
      appBar: PmateAppBar(title: local.bugs_and_fixes_page_title),
      body: SafeArea(child: Container()),
      //TODO: Connect with an email service provider
    );
  }
}
