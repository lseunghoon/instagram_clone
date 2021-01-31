import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/common_size.dart';

InputDecoration inputTextDeco(String hint) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.grey[100],
    hintText: hint,
    focusedBorder: activeInputBorder(),
    enabledBorder: activeInputBorder(),
    focusedErrorBorder: errorInputBorder(),
    errorBorder: errorInputBorder(),
  );
}

OutlineInputBorder errorInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(common_s_gap),
    borderSide: BorderSide(color: Colors.redAccent),
  );
}

OutlineInputBorder activeInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(common_s_gap),
    borderSide: BorderSide(
      color: Colors.grey[300],
    ),
  );
}
