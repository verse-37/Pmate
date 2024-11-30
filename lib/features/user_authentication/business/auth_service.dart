import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pmate/env/common/snackbars.dart';
import 'package:pmate/features/app/navigation.dart';
import 'package:pmate/features/user_authentication/interface/auth_page.dart';

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

      await Future.delayed(const Duration(seconds: 1));

      if (context.mounted) {
        PmateSnackbars(
          title: local.sign_up_success,
          message: local.sign_up_success_2,
          contentType: ContentType.success,
        ).showSnackbar(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavigationCenter()),
        );
        //?Push to NavigationCenter and pop all other pages
      }
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
        PmateSnackbars(
          title: local.auth_failed,
          message: message,
          contentType: ContentType.failure,
        ).showSnackbar(context);
      }
    } catch (e) {
      Logger().e(e);
      if (context.mounted) {
        PmateSnackbars(
          title: local.error,
          message: e.toString(),
        ).showErrorToast(context: context);
      }
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    final local = AppLocalizations.of(context);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await Future.delayed(const Duration(seconds: 1));

      if (context.mounted) {
        PmateSnackbars(
          title: local.login_success,
          message: local.login_success_2,
          contentType: ContentType.success,
        ).showSnackbar(context);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NavigationCenter()),
        );
      }
    } on FirebaseAuthException catch (e) {
      Logger().e(e.code);
      String message = '';
      switch (e.code) {
        case 'invalid-credential':
          message = local.auth_invalid_credentials;
          break;
        default:
          message = local.auth_unidentified_error;
          break;
      }
      if (context.mounted) {
        PmateSnackbars(
          title: local.auth_failed,
          message: message,
          contentType: ContentType.failure,
        ).showSnackbar(context);
      }
    } catch (e) {
      Logger().e(e);
      if (context.mounted) {
        PmateSnackbars(
          title: local.error,
          message: e.toString(),
        ).showErrorToast(context: context);
      }
    }
  }

  Future<void> signOut({
    required BuildContext context,
  }) async {
    final local = AppLocalizations.of(context);

    await FirebaseAuth.instance.signOut();

    await Future.delayed(const Duration(seconds: 1));

    if (context.mounted) {
      PmateSnackbars(
        title: local.sign_out_success,
        message: local.sign_out_message,
        contentType: ContentType.success,
      ).showSnackbar(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AuthenticationPage()),
      );
    }
  }
}
