import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class SnackbarGenerator {
  AwesomeSnackbarContent snackbarContent;

  SnackbarGenerator({
    required String title,
    required String message,
    required ContentType contentType,
  }) : snackbarContent = AwesomeSnackbarContent(
          title: title,
          message: message,
          contentType: contentType,
        );

  SnackbarGenerator.copy(this.snackbarContent);

  void showSnackbar(BuildContext context) {
    final SnackBar snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: snackbarContent,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  //TODO: Show material banner function here!
}
