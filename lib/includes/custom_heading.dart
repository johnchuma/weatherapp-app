import 'package:flutter/material.dart';

Widget customHeading(String text) {
  return Text(
    text,
    style: const TextStyle(
        fontWeight: FontWeight.w600, color: Colors.white, fontSize: 28),
  );
}
