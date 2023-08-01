import 'package:chef_panel/helper/constant/styles.dart';
import 'package:flutter/material.dart';

class CustomConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onConfirm;

  const CustomConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: textBodyStyle,
      ),
      content: Wrap(children: [Text(message)]),
      actions: <Widget>[
        TextButton(
          child: const Text("Cancel"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: onConfirm,
          child: const Text("Ok"),
        ),
      ],
    );
  }
}
