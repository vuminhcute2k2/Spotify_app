import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/home/views/homepage_screen.dart';
import 'package:music_spotify_app/app/modules/login/views/login_screen.dart';
import 'package:music_spotify_app/common/authentication.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Auth>(
      builder: (authController) {
        if (authController.authenStateChanges != null) {
          return const HomePageScreen();
        } else {
          return const LogInScreen();
        }
      },
    );
  }
}