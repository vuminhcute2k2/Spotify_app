import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/splash/controller/splash_controller.dart';
//import 'package:music_spotify_app/app/modules/getstarted/views/getstarted_screen.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
   final SplashController splashController = Get.put(SplashController());
   
  @override
  void initState() {
    splashController.requestPermission();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image.asset('assets/images/img_spotify_logo_rgb_green.png',width: 266,height: 80,),
        ),
      ),
    );
  }
}