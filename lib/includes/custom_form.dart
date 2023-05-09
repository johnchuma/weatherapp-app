// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

Widget customForm(
    String title, String hint, TextEditingController textEditingController,
    [TextInputType? textInputType,
    bool? obscureText,
    bool? isPassword,
    Function? toggleView,
    String? password]) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // customHint(title),
      SizedBox(
        child: TextFormField(
          controller: textEditingController,
          obscureText: obscureText ?? false,
          cursorColor: Colors.white,
          validator: ((value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${title.toString().toLowerCase()}';
            }
            if (password != null) {
              if (value != password) {
                return 'Passwords does not match';
              }
            }
            return null;
          }),
          keyboardType: textInputType ?? TextInputType.text,
          style: const TextStyle(
              fontSize: 13, color: Colors.white, fontWeight: FontWeight.w900),
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            floatingLabelStyle:
                const TextStyle(fontSize: 17, color: Colors.white54),
            labelText: title,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white38)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white38)),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white)),
            labelStyle: const TextStyle(fontSize: 13, color: Colors.white38),
            focusColor: Colors.white,
            suffixIcon: isPassword != null
                ? obscureText == true
                    ? GestureDetector(
                        onTap: () {
                          toggleView!();
                        },
                        child: const Icon(
                          Ionicons.ios_eye_off,
                          color: Colors.white54,
                        ))
                    : GestureDetector(
                        onTap: () {
                          toggleView!();
                        },
                        child: const Icon(
                          Ionicons.ios_eye,
                          color: Colors.white54,
                        ))
                : const Icon(
                    Foundation.eye,
                    color: Colors.transparent,
                  ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white38)),
          ),
        ),
      ),
    ],
  );
}
