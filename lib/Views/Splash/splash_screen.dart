// 🎯 Dart imports:
import 'dart:math' as math;

// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import '../../Constant/themes.dart';
import '../../Controllers/splash_screen_controller.dart';
import '../../Widget/loading_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      children: [
        //background color
        Positioned(bottom: 0, left: 0, right: 0, top: 0, child: backGround()),

        Positioned(top: -0, right: -40, child: _hand1()),

        Positioned(left: -20, top: 0, child: _hand2()),

        Positioned(right: -75, bottom: 0, child: _hand3()),

        Positioned(left: -30, bottom: -10, child: _hand4()),

        Positioned(left: 0, bottom: 0, top: 0, right: 0, child: _text()),
      ],
    );
  }

  Widget backGround() {
    return Container(
      decoration: const BoxDecoration(
        gradient: SweepGradient(
          center: Alignment(0.20, -0.15),
          startAngle: 2 * math.pi / 2,
          endAngle: 5 * math.pi / 2,
          tileMode: TileMode.mirror,
          colors: <Color>[
            loadScreenColor1,
            loadScreenColor2,
            primaryColor,
          ],
          stops: <double>[0.1, 0.65, 1.0],
        ),
      ),
    );
  }

  Widget _hand1() {
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(
          -3.8 / 4,
        ),
        child: Image.asset(
          'assets/images/handbagging.png',
          width: 200,
        ));
  }

  Widget _hand2() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationZ(
        3.8 / 4,
      ),
      child: Image.asset(
        'assets/images/handmaking.png',
        width: 120,
      ),
    );
  }

  Widget _hand3() {
    return Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationZ(
          -3.16 / 2,
        ),
        child: Image.asset(
          'assets/images/handraise.png',
          width: 220,
        ));
  }

  Widget _hand4() {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.rotationZ(
        -3.8 / 4,
      ),
      child: Image.asset(
        'assets/images/handright.png',
        width: 150,
      ),
    );
  }

  Widget _text() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///app name
          RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(children: [
                TextSpan(text: 'Fami', style: TextStyle(color: famGreen, fontSize: 42, fontWeight: FontWeight.bold)),
                TextSpan(text: 'Test', style: TextStyle(color: famBlue, fontSize: 42, fontWeight: FontWeight.bold)),
              ])),

          ///loading indicator
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: loadingIndicator(),
          )
        ],
      ),
    );
  }
}
