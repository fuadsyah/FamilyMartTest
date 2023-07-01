// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:get/get.dart';

// 🌎 Project imports:
import '../Constant/themes.dart';
import '../Controllers/root_screen_controller.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RootScreenController rsc = Get.put(RootScreenController());
    return Scaffold(
      body: _body(rsc),
    );
  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
      backgroundColor: primaryColor,
      toolbarHeight: 20,
      flexibleSpace: SafeArea(
        child: Row(
          children: [
            ///search collection field
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 15, top: 10,bottom: 10,right: 25),
                height: 45,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(13), border: Border.all(color: famGreen)),
                child: const TextField(
                  showCursor: false,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      border: InputBorder.none,
                      suffixIcon: Icon(CupertinoIcons.search_circle),
                      suffixIconConstraints: BoxConstraints.tightFor(width: 50),
                      hintText: 'Search Collection',
                      hintStyle: TextStyle(fontSize: 13)),
                ),
              ),
            ),

            ///notification
            const Padding(
              padding: EdgeInsets.only(right: 25),
              child: Icon(CupertinoIcons.bell, color: famBlue),
            )
          ],
        ),
      ),
      // title: ,
    );
  }

  Widget _body(RootScreenController rsc) {
    return Stack(
      children: [
        Obx(
          () => PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: rsc.pageController.value,
              children: rsc.screenList),
        ),

        Positioned(top: 0, left: 0, right: 0, child: _appBar()),

        ///floating bottom navigation bar
        Positioned(
          bottom: 25,
          left: 0,
          right: 0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 0),
              )
            ], color: primaryColor, borderRadius: BorderRadius.circular(50)),
            child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ///movies
                    GestureDetector(
                      onTap: () => rsc.onChangeScreen(type: 'movies'),
                      child: Column(
                        children: [
                          Icon(CupertinoIcons.play_circle, color: rsc.getMenuColor('movies')),
                          Text('Movies', style: TextStyle(color: rsc.getMenuColor('movies'))),
                        ],
                      ),
                    ),

                    ///television
                    GestureDetector(
                      onTap: () => rsc.onChangeScreen(type: 'television'),
                      child: Column(
                        children: [
                          Icon(CupertinoIcons.tv, color: rsc.getMenuColor('television')),
                          Text('Television', style: TextStyle(color: rsc.getMenuColor('television'))),
                        ],
                      ),
                    ),

                    ///Profile
                    GestureDetector(
                      onTap: () => rsc.onChangeScreen(type: 'profile'),
                      child: Column(
                        children: [
                          Icon(CupertinoIcons.profile_circled, color: rsc.getMenuColor('profile')),
                          Text('Profile', style: TextStyle(color: rsc.getMenuColor('profile'))),
                        ],
                      ),
                    )
                  ],
                )),
          ),
        )
      ],
    );
  }
}
