import 'package:flutter/material.dart';

extension Snackbar on BuildContext {
  void showSnackbar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
  }) {
    final SnackBar snackBar = SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: backgroundColor,
      content: Text(message, style: const TextStyle(color: Colors.white)),
      action: SnackBarAction(label: 'Close', onPressed: () {}),
    );

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
