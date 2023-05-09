import 'package:app/utils/custom_colors.dart';
import 'package:flutter/material.dart';

Widget customButton(String text, [Color? color]) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Container(
        color: color ?? CustomColors.themeColor,
        width: double.infinity,
        height: 50,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 15,
                fontWeight: FontWeight.w900),
          ),
        )),
  );
}
