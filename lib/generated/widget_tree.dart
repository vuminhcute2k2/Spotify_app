import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/getstarted/views/getstarted_screen.dart';
import 'package:music_spotify_app/app/modules/home/views/homepage_screen.dart';
import 'package:music_spotify_app/app/modules/home/views/navigatorhome_screen.dart';
import 'package:music_spotify_app/common/authentication.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    // return Obx(
    //   () {
    //     final authController = Get.find<Auth>();

    //     if (authController.authenStateChanges != null) {
    //       return const HomePageScreen();
    //     } else {
    //       return const GetStartedScreen();
    //     }
    //   },
    // );
    return StreamBuilder(
      builder: (context, snapshotdata) {
        if (snapshotdata.hasData) {
          return const NavigatorHomeScreen();
        } else {
          return const GetStartedScreen();
        }
      },
      stream: Auth().authenStateChanges,
    );
  }
}
