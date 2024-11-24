import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthValidator {
  MultiValidator passwordValidator({
    required BuildContext context,
    required String missingMessage,
  }) {
    final local = AppLocalizations.of(context);
    final min = 8;

    return MultiValidator([
      RequiredValidator(errorText: missingMessage),
      MinLengthValidator(min, errorText: local.auth_password_too_short(min)),
      WhitespaceValidator(errorText: local.auth_no_space_allowed)
    ]);
  }

  MultiValidator emailValidator({required BuildContext context}) {
    final local = AppLocalizations.of(context);

    return MultiValidator([
      RequiredValidator(errorText: local.auth_email_missing),
      EmailValidator(errorText: local.auth_email_not_valid),
    ]);
  }
}

class WhitespaceValidator extends TextFieldValidator {
  WhitespaceValidator({required String errorText}) : super(errorText);

  @override
  bool get ignoreEmptyValues => true;

  @override
  bool isValid(String? value) {
    return !value!.contains(' ');
  }
}
