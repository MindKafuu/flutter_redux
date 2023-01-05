import 'package:flutter/material.dart';

Widget textInputNormal(
    {bool readonly = false,
    int maxLength = 100,
    int maxLines = 1,
    String label = '',
    String hintText = '',
    bool obscureText = false,
    Widget? prefixIcon: null,
    Widget? suffixIcon: null,
    TextEditingController? controller: null}) {
  return TextField(
    readOnly: readonly,
    maxLength: maxLength,
    maxLines: maxLines,
    obscureText: obscureText,
    controller: controller,
    style: const TextStyle(fontSize: 16),
    decoration: InputDecoration(
        prefixIcon: (prefixIcon != null) ? prefixIcon : null,
        suffixIcon: (suffixIcon != null) ? suffixIcon : null,
        label: Text(label),
        counterText: "",
        hintText: label),
  );
}
