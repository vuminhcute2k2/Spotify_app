import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_spotify_app/app.dart';
import 'package:music_spotify_app/app/modules/home/controller/profile_controller.dart';
// void main()async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const SpotifyScreen());
// }
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
    // Handle Firebase initialization error
  }

  try {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
    print('JustAudioBackground initialized successfully');
  } catch (e) {
    print('Error initializing JustAudioBackground: $e');
    // Handle JustAudioBackground initialization error
  }
 Get.create(() => ProfileController());
  runApp(const SpotifyScreen());
}
//Cập Nhật Cấu Hình Xác Nhận Chứng Chỉ
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

