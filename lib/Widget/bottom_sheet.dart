// 🎯 Dart imports:
import 'dart:ui';

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

void showCustomBottomSheet({required Widget child, bool usePadding = true}) {
  Get.bottomSheet(
    BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Padding(
        padding: Get.context!.mediaQueryViewInsets,
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(Get.context!).padding.top),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(Get.context!).viewInsets.bottom+20, top: 15, left: 15, right: 15),
            child: child,
          ),
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    useRootNavigator: true,
  );
}
