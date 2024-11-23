import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: unused_import
import 'package:logger/logger.dart';
import 'package:pmate/env/common/buttons.dart';
import 'package:pmate/features/user_authentication/interface/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    void onExit() {
      Navigator.pop(context);
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: SignupLink(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 25.0,
            ),
            child: LoginForm(),
          ),
        ),
      ),
    );
  }
}

class SignupLink extends StatelessWidget {
  const SignupLink({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    void onSignup() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupPage(),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
                text: local.login_new_user,
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.normal,
                  fontSize: theme.textTheme.bodyMedium?.fontSize ?? 16,
                )),
            TextSpan(
              text: local.login_create_account,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()..onTap = onSignup,
              //?Chain method works somehow...
            )
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  //When I decide to separate the login fields into their own widgets, I am concerned that the controller being passed to the individual fields will not in sync with the controllers here.
  //Turns out, the controllers in the field widgets still holds the reference to the controllers here, which is a day-saving thing.

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    void onLoginAttempt() {}

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        Text(
          local.login_title,
          style: theme.textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 50,
        ),
        LoginEmailField(emailController: _email),
        const SizedBox(
          height: 20,
        ),
        LoginPasswordField(passwordController: _password),
        const SizedBox(
          height: 30,
        ),
        LargeButton(
          text: local.log_in,
          action: onLoginAttempt,
        ),
      ],
    );
  }
}

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({
    super.key,
    required TextEditingController emailController,
  }) : _email = emailController;

  final TextEditingController _email;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(local.email_address),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextField(
          controller: _email,
          decoration: InputDecoration(
            filled: true,
            hintText: local.email_example,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ],
    );
  }
}

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({
    super.key,
    required TextEditingController passwordController,
  }) : _password = passwordController;

  final TextEditingController _password;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(local.password),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextField(
          controller: _password,
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ],
    );
  }
}
