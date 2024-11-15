import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({
    super.key,
    this.title,
    this.errorMsg
  });

  final String? title;
  final String? errorMsg;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title?? "Error"),
      content: Text(errorMsg ?? "error"),
      actions: [
        ElevatedButton(
            onPressed: () => {Navigator.pop(context)},
            child: const Text("Exit"))
      ],
    );
  }
}