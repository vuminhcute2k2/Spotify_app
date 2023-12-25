import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/home/views/homepage_screen.dart';
import 'package:music_spotify_app/app/modules/home/views/navigatorhome_screen.dart';
import 'package:music_spotify_app/app/modules/login/views/login_screen.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/common/authentication.dart';

class SpotifyScreen extends StatelessWidget {
  const SpotifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRouterName.Splash,
      onGenerateRoute:AppRouter.onGenerateRoute ,
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: StreamBuilder(
        stream:FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData){
              return const NavigatorHomeScreen();
            }else if(snapshot.hasError){
              return Center(child: Text('${snapshot.error}'),
              );
            }
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(color:Color(0XFFFBC16A)) ,
            );
          }
          return const LogInScreen();
        },
      ),
      // initialBinding: BindingsBuilder(() {
      //   Get.put(Auth());
      // }),
    );
  }
}