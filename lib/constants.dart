import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

TextField InfoTextField({required String hintText, required Function(String) onChanged, bool isPassword = false,}) {
  return TextField(
    onChanged: onChanged, // Use the onChanged callback here
    decoration: InputDecoration(
      border: InputBorder.none,
      fillColor: Colors.blueGrey,
      filled: true,
      hintText: hintText, // Set the hint text
      hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      contentPadding: EdgeInsets.all(8),
    ),
  );
}
