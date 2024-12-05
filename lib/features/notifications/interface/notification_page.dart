import 'package:flutter/material.dart';
import 'package:pmate/env/models/pmate_page.dart';
import 'package:pmate/env/widgets/appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/features/app/business/page_info_provider.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatelessWidget implements PmatePage {
  const NotificationPage({super.key});

  @override
  String get routeName => '/notifications';
  @override
  String get routePath => '/notifications';

  @override
  void init(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    context.read<PageInfoProvider>().setTitle(l10n.notification_page_title);
    context.read<PageInfoProvider>().setActions([]);
  }

  @override
  Widget build(BuildContext context) {
    init(context);

    final local = AppLocalizations.of(context);

    return Scaffold(
      appBar: PmateAppBar(title: local.notification_page_title),
      body: SafeArea(child: Container()),
    );
  }
}
