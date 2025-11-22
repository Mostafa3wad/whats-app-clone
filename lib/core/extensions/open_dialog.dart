import 'package:flutter/material.dart';

extension Dialog on BuildContext {
  void openDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String doneTitle,
    required void Function()? doneOnPress,
    Color? doneColor,
  }) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.start,
        ),
        content: Text(
          content,
          textAlign: TextAlign.start,
          style: const TextStyle(
            height: 1.5,
          ),
        ),
        actions: <Widget>[
          OutlinedButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          FilledButton(
            onPressed: doneOnPress,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                doneColor,
              ),
            ),
            child: Text(doneTitle),
          ),
        ],
      ),
    );
  }
}
