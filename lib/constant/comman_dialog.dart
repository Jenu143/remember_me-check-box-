import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> commanDialog({required BuildContext context, String? error}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(title: Text(error!));
    },
  );
}

Future<void> circulerDialog({required BuildContext context}) {
  return showDialog(
    context: context,
    builder: (context) {
      return const Center(child: CircularProgressIndicator());
    },
  );
}

void screenBack(BuildContext context) {
  Navigator.of(context).pop();
}

late SharedPreferences preferences;
