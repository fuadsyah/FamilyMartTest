// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import '../Constant/themes.dart';

GetSnackBar customSnackBar(
    {required String message,
    required bool isWarning,
    bool isDismissible = true,
    SnackPosition position = SnackPosition.BOTTOM}) {
  return GetSnackBar(
    message: message,
    backgroundColor: isWarning ? Colors.red : famGreen,
    isDismissible: isDismissible,
    duration: Duration(seconds: isWarning ? 2 : 3),
    animationDuration: const Duration(milliseconds: 500),
    margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    borderRadius: 10,
    snackPosition: position,
  );
}

void showSnackBar({required bool isWarning, required String message}) {
  Get.showSnackbar(customSnackBar(isWarning: isWarning, message: message));
}
