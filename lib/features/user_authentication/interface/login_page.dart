import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    void onExit() {
      Navigator.pop(context);
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              IconButton(
                onPressed: onExit,
                icon: Icon(Icons.turn_left_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
