import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
// ignore: unused_import
import 'package:logger/logger.dart';
import 'package:pmate/env/widgets/buttons.dart';
import 'package:pmate/features/support/interface/subpages/bugs_and_fixes_page.dart';
import 'package:pmate/features/user_authentication/business/auth_service.dart';
import 'package:pmate/features/user_authentication/interface/signup_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const routeName = 'login';
  static const routePath = '/auth/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: const SignupLink(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const SafeArea(
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
      context.push(SignupPage.routePath);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: theme.textTheme.bodyMedium,
          children: [
            TextSpan(
              text: local.login_new_user,
            ),
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
  final _loginFormKey = GlobalKey<FormState>();
  //When I decide to separate the login fields into their own widgets, I am concerned that the controller being passed to the individual fields will not in sync with the controllers here.
  //Turns out, the controllers in the field widgets still holds the reference to the controllers here, which is a day-saving thing.

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    void onPasswordReset() {
      //TODO: Implement
    }

    void onLoginAttempt() async {
      await AuthService().signIn(
        email: _email.text.trim(),
        password: _password.text.trim(),
        context: context,
      );
    }

    void onVerse37Contact() {
      context.push(BugsAndFixesPage.routePath);
    }

    return Form(
      key: _loginFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            local.login_title,
            style: theme.textTheme.displayMedium,
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
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              RichText(
                text: TextSpan(
                  text: local.login_password_forgot,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onPasswordReset,
                  //?See the EXPLANATION in the bottom of the file.
                  //?recognizer property only works with TextSpan
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          LargeButton(
            text: local.log_in,
            action: onLoginAttempt,
          ),
          const SizedBox(
            height: 10,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: local.login_contact_1,
                  style: theme.textTheme.bodyMedium,
                ),
                TextSpan(
                  text: local.contact_v37,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()..onTap = onVerse37Contact,
                  //?See the EXPLANATION in the bottom of the file.
                )
              ],
            ),
          )
        ],
      ),
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
    final theme = Theme.of(context);

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
        TextFormField(
          controller: _email,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          enableSuggestions: false,
          decoration: InputDecoration(
            filled: true,
            hintText: local.email_example,
            hintStyle: theme.textTheme.bodyMedium,
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

class LoginPasswordField extends StatefulWidget {
  const LoginPasswordField({
    super.key,
    required TextEditingController passwordController,
  }) : _password = passwordController;

  final TextEditingController _password;

  @override
  State<LoginPasswordField> createState() => _LoginPasswordFieldState();
}

class _LoginPasswordFieldState extends State<LoginPasswordField> {
  bool passwordVisibility = false;

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);

    void onVisibilityChanged() {
      setState(() {
        passwordVisibility = !passwordVisibility;
      });
    }

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
        TextFormField(
          controller: widget._password,
          keyboardType: TextInputType.visiblePassword,
          autocorrect: false,
          enableSuggestions: false,
          obscureText: !passwordVisibility,
          decoration: InputDecoration(
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.0),
            ),
            suffixIcon: IconButton(
              onPressed: onVisibilityChanged,
              icon: Icon(
                (passwordVisibility)
                    ? Icons.visibility //
                    : Icons.visibility_off,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*
The `..` operator in Dart is called the "cascade notation" operator. It allows you to perform multiple operations on the same object without having to repeat the reference to that object. Here's the difference:

With single dot `.`:
```dart
final recognizer = TapGestureRecognizer();
recognizer.onTap = onSignup;
```

With cascade notation `..`:
```dart
TapGestureRecognizer()..onTap = onSignup
```

The key differences are:
1. The cascade notation returns the original object (the `TapGestureRecognizer` instance), not the result of the operation after the `..`
2. This allows you to chain multiple operations and still use the original object in a single expression
3. It's particularly useful when you want to initialize an object and set some properties in a single line

For example, you could even do multiple operations:
```dart
TapGestureRecognizer()
  ..onTap = onSignup
  ..onTapDown = onTapDown
  ..onTapCancel = onTapCancel;
```

In your specific case, the cascade notation is used because you need to return the `TapGestureRecognizer` instance for the `recognizer` property, but you also want to set its `onTap` callback. Using `.` would return `void` (the return type of the assignment), while `..` returns the recognizer itself.

*/