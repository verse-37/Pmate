import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/common/snackbars.dart';

class AuthService {
  Future<void> signUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final local = AppLocalizations.of(context);

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      String message = '';
      switch (e.code) {
        case 'weak-password':
          message = local.auth_password_too_weak;
          break;
        case 'email-already-in-use':
          message = local.auth_email_already_exists;
          break;
        default:
          message = local.auth_unidentified_error;
          break;
      }
      if (context.mounted) {
        //If the parent widget still exists...
        SnackbarGenerator(
          title: local.auth_failed,
          message: message,
          contentType: ContentType.failure,
        ).showSnackbar(context);
      }
    } catch (e) {
      Logger().e(e);
    }
  }
}
