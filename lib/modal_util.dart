import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:toastification/toastification.dart';
import 'package:universal_platform/universal_platform.dart';

part 'widgets/input_match_confirmation.dart';
part 'widgets/email_password_input.dart';

class ModalUtil {
  static void showSnackbar(BuildContext context, String title) =>
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(title)));

  static Future<(String, String)?> showEmailPasswordDialog(
    BuildContext context,
  ) async => showDialog<(String, String)?>(
    context: context,
    useRootNavigator: false,
    barrierDismissible: false,
    builder: (BuildContext context) => Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 128),
      child: EmailPasswordInputWidget(
        onSubmit: (email, password) =>
            Navigator.of(context).pop((email, password)),
        onCancel: () => Navigator.of(context).pop(),
      ),
    ),
  );

  static void showSuccess(BuildContext context, {required String title}) {
    _showToast(
      context,
      title: title,
      toastificationType: ToastificationType.success,
      icon: const Icon(Icons.check),
      primaryColor: Colors.green,
    );
  }

  static void showError(BuildContext context, {required String title}) {
    _showToast(
      context,
      title: title,
      toastificationType: ToastificationType.error,
      icon: const Icon(Icons.error),
      primaryColor: Colors.red,
    );
  }

  /// Shows a brief, customizable toast.
  static void _showToast(
    BuildContext context, {
    required String title,
    required ToastificationType toastificationType,
    required Widget icon,
    required MaterialColor primaryColor,
  }) {
    toastification.show(
      context: context,
      autoCloseDuration: const Duration(seconds: 3),
      title: Text(title),
      type: toastificationType,
      style: ToastificationStyle.fillColored,
      icon: icon,
      primaryColor: primaryColor,
      backgroundColor: primaryColor.shade100,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),
      showProgressBar: false,
      closeButton: ToastCloseButton(showType: CloseButtonShowType.onHover),
      closeOnClick: true,
    );
  }

  static Future<bool?> showInputMatchConfirmation({
    required BuildContext context,
    required String title,
    required String hintText,
    required String match,
  }) => showDialog<bool>(
    useRootNavigator: false,
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => Material(
      color: Colors.transparent,
      child: InputMatchConfirmationWidget(
        hintText: hintText,
        title: title,
        match: match,
      ),
    ),
  );

  static Future<bool?> showConfirmation(
    BuildContext context, {
    required String title,
    required String message,
  }) async => await showDialog<bool>(
    useRootNavigator: false,
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) =>
        UniversalPlatform.isIOS || UniversalPlatform.isMacOS
        ? CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: false,
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          )
        : AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('NO'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('YES'),
              ),
            ],
          ),
  );
}
