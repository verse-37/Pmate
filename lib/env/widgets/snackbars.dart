import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class PmateSnackbars {
  String title;
  String message;

  PmateSnackbars({
    required this.title,
    required this.message,
  });

  void showSnackbar(BuildContext context, ContentType contentType) {
    final SnackBar snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void showMaterialBanner(BuildContext context, ContentType contentType) {
    final MaterialBanner materialBanner = MaterialBanner(
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
        inMaterialBanner: true,
      ),
      actions: const [SizedBox.shrink()],
    );

    ScaffoldMessenger.of(context)
      ..clearMaterialBanners()
      ..showMaterialBanner(materialBanner);
  }

  void showToast({
    required BuildContext context,
    int duration = 5,
    required ToastificationType type,
  }) {
    toastification.show(
      context: context,
      type: type,
      style: ToastificationStyle.flat,
      autoCloseDuration: Duration(seconds: duration),
      title: Text(
        title,
        style: Theme.of(context).textTheme.displaySmall,
      ),
      description: Text(
        message,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }
}
