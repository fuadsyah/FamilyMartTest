// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import '../../Views/Splash/splash_screen.dart';
import 'Utils/scroll_physics.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FamiTest',
        builder: (context, widget) {
          return ScrollConfiguration(behavior: const ScrollBehaviorModified(), child: widget!);
        },
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(
                fontSizeFactor: 0.75,
                fontSizeDelta: 1.5,
              ),
        ),
        home: const SplashScreen());
  }
}
