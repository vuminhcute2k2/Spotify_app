import 'package:flutter/material.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';

class SpotifyScreen extends StatefulWidget {
  const SpotifyScreen({super.key});

  @override
  State<SpotifyScreen> createState() => _SpotifyScreenState();
}

class _SpotifyScreenState extends State<SpotifyScreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouterName.Splash,
      onGenerateRoute:AppRouter.onGenerateRoute ,
    );
  }
}