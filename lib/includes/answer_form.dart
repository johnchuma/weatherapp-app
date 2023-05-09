// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';

Widget answerForm(
  String title,
  String hint,
  TextEditingController textEditingController, [
  TextInputType? textInputType,
]) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // customHint(title),
      SizedBox(
        child: TextFormField(
          controller: textEditingController,
          cursorColor: Colors.white,
          validator: ((value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${title.toString().toLowerCase()}';
            }
            // ignore: deprecated_member_use
            if (int.parse(value, onError: (err) => 0) == 0) {
              return 'This value is not valid';
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
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(color: Colors.white38)),
          ),
        ),
      ),
    ],
  );
}
