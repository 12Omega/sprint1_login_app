import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, {Color? color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: color ?? Colors.red,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
