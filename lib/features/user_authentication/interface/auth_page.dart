import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/common/buttons.dart';
import 'package:pmate/features/user_authentication/interface/login_page.dart';
import 'package:pmate/features/user_authentication/interface/signup_page.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    void onLogin() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }

    void onSignup() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupPage(),
        ),
      );
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
                SizedBox(
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
