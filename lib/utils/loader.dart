import 'package:app/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showLoader() {
  Get.defaultDialog(
      backgroundColor: Colors.transparent,
      title: "",
      content: const CircularProgressIndicator(
        color: CustomColors.themeColor,
      ));
}
