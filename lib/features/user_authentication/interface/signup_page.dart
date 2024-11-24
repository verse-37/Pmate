import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// ignore: unused_import
import 'package:logger/logger.dart';
import 'package:pmate/env/common/buttons.dart';
import 'package:pmate/env/common/snackbars.dart';
import 'package:pmate/features/user_authentication/business/auth_validators.dart';
import 'package:pmate/features/user_authentication/interface/login_page.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: LoginLink(),
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
            child: SignupForm(),
          ),
        ),
      ),
    );
  }
}

class LoginLink extends StatelessWidget {
  const LoginLink({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    void onSignup() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
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
                text: local.sign_up_account_already,
                style: TextStyle(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.normal,
                  fontSize: theme.textTheme.bodyMedium?.fontSize ?? 16,
                )),
            TextSpan(
              text: local.log_in,
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

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordRetype = TextEditingController();
  final _signupFormKey = GlobalKey<FormState>();
  //? Create a global key that uniquely identifies the Form widget
  //? and allows validation of the form.
  //? Also, Using a GlobalKey is the recommended way to access a form.
  //? See additional info at: https://docs.flutter.dev/cookbook/forms/validation

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);

    void onSignupAttempt() {
      if (!_signupFormKey.currentState!.validate()) {
        SnackbarGenerator(
          title: local.auth_failed,
          message: local.sign_up_fields_incomplete,
          contentType: ContentType.failure,
        ).showSnackbar(context);
      } else if (_password.text != _passwordRetype.text) {
        SnackbarGenerator(
          title: local.auth_failed,
          message: local.auth_passwords_do_not_match,
          contentType: ContentType.failure,
        ).showSnackbar(context);
      } else {}
    }

    return Form(
      key: _signupFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            local.sign_up_title,
            style: theme.textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 50,
          ),
          SignupEmailField(emailController: _email),
          const SizedBox(
            height: 20,
          ),
          SignupPasswordField(
            title: local.password,
            passwordController: _password,
            errorText: local.auth_password_missing,
          ),
          const SizedBox(
            height: 20,
          ),
          SignupPasswordField(
            title: local.sign_up_retype_password,
            passwordController: _passwordRetype,
            errorText: local.auth_password_retype_missing,
          ),
          const SizedBox(
            height: 30,
          ),
          LargeButton(
            text: local.sign_up,
            action: onSignupAttempt,
          ),
        ],
      ),
    );
  }
}

class SignupEmailField extends StatefulWidget {
  const SignupEmailField({
    super.key,
    required TextEditingController emailController,
  }) : _email = emailController;

  final TextEditingController _email;

  @override
  State<SignupEmailField> createState() => _SignupEmailFieldState();
}

class _SignupEmailFieldState extends State<SignupEmailField> {
  bool isFieldEmpty = false;

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
        TextFormField(
          controller: widget._email,
          keyboardType: TextInputType.emailAddress,
          autocorrect: false,
          enableSuggestions: false,
          validator: AuthValidator().emailValidator(context: context).call,
          decoration: InputDecoration(
            filled: true,
            hintText: local.email_example,
            errorText: (isFieldEmpty ? local.auth_email_missing : null),
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

class SignupPasswordField extends StatefulWidget {
  const SignupPasswordField({
    super.key,
    required TextEditingController passwordController,
    required this.title,
    required this.errorText,
  }) : _password = passwordController;

  final TextEditingController _password;
  final String title;
  final String errorText;

  @override
  State<SignupPasswordField> createState() => _SignupPasswordFieldState();
}

class _SignupPasswordFieldState extends State<SignupPasswordField> {
  bool passwordVisibility = false;
  bool isFieldEmpty = false;

  @override
  Widget build(BuildContext context) {
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
          child: Text(widget.title),
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
          validator: AuthValidator()
              .passwordValidator(
                context: context,
                missingMessage: widget.errorText,
              )
              .call,
          decoration: InputDecoration(
            filled: true,
            errorText: (isFieldEmpty) ? widget.errorText : null,
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
