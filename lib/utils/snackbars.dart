import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void successSnackbar(String? title, String? details) {
  Get.showSnackbar(GetSnackBar(
    duration: const Duration(seconds: 2),
    title: title,
    icon: const Icon(
      Icons.done,
      color: Colors.green,
    ),
    message: details,
  ));
}

void failureSnackbar(DioError e) {
  Get.showSnackbar(GetSnackBar(
    duration: const Duration(seconds: 2),
    title: "Oops! sorry",
    icon: const Icon(
      Icons.dangerous,
      color: Colors.red,
    ),
    message: e.response?.data["message"],
  ));
}
