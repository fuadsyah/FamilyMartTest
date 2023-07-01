// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import '../../Constant/themes.dart';
import '../../Views/Profile/profile_screen.dart';
import '../../Views/Television/tv_screen.dart';
import '../Views/Movie/movies_screen.dart';

class RootScreenController extends GetxController {
  final Rx<PageController> pageController = PageController(keepPage: true).obs;
  var screenList = [const HomeScreen(), const TelevisionScreen(), const ProfileScreen()];
  var selectedScreen = 'movies'.obs;
  var selectedColor = Colors.black54.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    pageController.value.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    pageController.value.dispose();
    super.onClose();
  }

  void onChangeScreen({required type}) {
    switch (type) {
      case ('movies'):
        {
          selectedScreen.value = type;
          getMenuColor(type);
          pageController.value.animateToPage(0, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
        }
        break;
      case ('television'):
        {
          selectedScreen.value = type;
          getMenuColor(type);
          pageController.value.animateToPage(1, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
        }
        break;
      case ('profile'):
        {
          selectedScreen.value = type;
          getMenuColor(type);
          pageController.value.animateToPage(2, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
        }
        break;
      default:
        break;
    }
  }

  Color getMenuColor(type) {
    if (selectedScreen.value == type) {
     return  famBlue;
    } else {
      return Colors.black54;
    }
  }
}
