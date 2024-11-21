import 'package:flutter/material.dart';
import 'package:pmate/env/common/primitives.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class WelcomeProvider extends ChangeNotifier {
  late final String userName;
  late final List<Pair<String, String>> script;

  void setUsername(String user) {
    userName = user;
    notifyListeners();
  }

  void init(BuildContext context) {
    final local = AppLocalizations.of(context);

    script = [
      Pair(
        local.intro_header_1(userName),
        local.intro_param_1,
      ),
      Pair(
        local.intro_header_2,
        local.intro_param_2,
      ),
      Pair(
        local.intro_header_3,
        local.intro_param_3,
      ),
      Pair(
        local.intro_header_4,
        local.intro_param_4,
      )
    ];
  }
}
