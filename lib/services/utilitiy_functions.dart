import 'package:flutter/material.dart';
import 'package:pirai_code_challenge/main.dart';

void showSnackBar(message) {
  ScaffoldMessenger.of(navigatorKey.currentState!.context)
      .showSnackBar(SnackBar(
    content: Text(message),
  ));
}
