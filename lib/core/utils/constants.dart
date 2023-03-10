import 'package:flutter/material.dart';

class AppConstants {
  static showSnackBar({
    required context,
    required message,
    action,
    onPressed,
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: action ?? ' ',
        onPressed: onPressed ?? () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
