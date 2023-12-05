import 'package:flutter/material.dart';
import 'package:music_spotify_app/app/modules/getstarted/views/getstarted_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const GetStartedScreen()),
      );
    });
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