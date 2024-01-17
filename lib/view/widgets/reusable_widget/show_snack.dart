
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showSnackbar(String title, String message, Color color) async {
  Get.snackbar(
    title,
    message,
    backgroundColor: color,
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
  );
}
