// 🐦 Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:url_launcher/url_launcher.dart';

// 🌎 Project imports:
import '../../Constant/themes.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            ///white space
            const SizedBox(height: 110),

            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/images/profile.png"),
            ),

            const SizedBox(height: 10),
            const Text("M. Fuadsyah", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
            const SizedBox(height: 10),
            const Text("Flutter Developer", style: TextStyle(color: Colors.grey, fontSize: 11)),

            Container(
              margin: const EdgeInsets.only(top: 20, left: 22, right: 22),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// General information
                    const Text("General Information",
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 13),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8), color: Colors.white),
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () async {
                              if (!await launchUrl(
                                Uri.parse("mailto:fuadsyah.work@gmail.com"),
                              )) {
                                throw Exception('Could not launch repository');
                              }
                            },
                            contentPadding: const EdgeInsets.symmetric(horizontal: 13),
                            title: const Text('Mail'),
                            trailing: const Text("fuadsyah.work@gmail.com",
                                style: TextStyle(color: Color(0xFFC4C4C4))),
                          ),
                          const Divider(height: 0, thickness: 1),
                          ListTile(
                            onTap: () async {
                              if (!await launchUrl(
                                Uri.parse("tel:+6281228809923"),
                              )) {
                                throw Exception('Could not launch repository');
                              }
                            },
                            contentPadding: const EdgeInsets.symmetric(horizontal: 13),
                            title: const Text('Phone'),
                            trailing: const Text('081228809923',
                                style: TextStyle(color: Color(0xFFC4C4C4))),
                          ),
                          const Divider(height: 0, thickness: 1),
                          ListTile(
                              onTap: () async {
                                if (!await launchUrl(
                                  Uri.parse("https://github.com/fuadsyah/FamilyMartTest"),
                                  mode: LaunchMode.externalApplication,
                                )) {
                                  throw Exception('Could not launch repository');
                                }
                              },
                              contentPadding: const EdgeInsets.symmetric(horizontal: 13),
                              title: const Text('App Repository'),
                              trailing: const Icon(CupertinoIcons.forward)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
