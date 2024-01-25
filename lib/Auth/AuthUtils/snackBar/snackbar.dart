import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:MysqlApp/Utils/TextStyles/BigText.dart';

void showCustomSnackBar(String message,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(title, message,
      titleText: BigText(
        text: title,
        color: Colors.black,
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      colorText: Colors.black,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.redAccent);
}
