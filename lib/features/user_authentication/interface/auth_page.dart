import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:pmate/env/widgets/buttons.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    void onLogin() {
      context.push('/auth/login');
    }

    void onSignup() {
      context.push('/auth/signup');
    }

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedLargeButton(
                  text: local.log_in,
                  action: onLogin,
                  primaryColorText: true,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                RoundedLargeButton(
                  text: local.sign_up,
                  action: onSignup,
                  primaryColorText: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
