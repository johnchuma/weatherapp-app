import 'package:flutter/material.dart';

Widget customHint(String text, [TextAlign? alignment]) {
  return Text(text,
      textAlign: alignment ?? TextAlign.start,
      style: const TextStyle(
          fontWeight: FontWeight.w400, color: Colors.white54, fontSize: 12));
}
