import 'package:flutter/material.dart';
import 'package:music_spotify_app/app/modules/continue/views/continue_screen.dart';
import 'package:music_spotify_app/app/modules/home/views/navigatorhome_screen.dart';
import 'package:music_spotify_app/common/authentication.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshotdata) {
        if (snapshotdata.hasData) {
          return const NavigatorHomeScreen();
        } else {
          return const ContinueScreen();
        }
      },
      stream: Auth().authenStateChanges,
    );
  }
}
