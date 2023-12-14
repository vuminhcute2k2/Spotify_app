// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:music_spotify_app/app/modules/continue/views/continue_screen.dart';
// import 'package:music_spotify_app/app/modules/home/views/navigatorHome_screen.dart';
// import 'package:music_spotify_app/app/modules/login/views/login_screen.dart';
// import 'package:music_spotify_app/app/modules/register/views/register_screen.dart';
// import 'package:music_spotify_app/app/modules/signup/views/signup_screen.dart';
// import 'package:music_spotify_app/app/modules/splash/views/splash_screen.dart';

// class AppRouter{
//   static MaterialPageRoute? onGenerateRoute(RouteSettings settings){
//     switch(settings.name){
//       case AppRouterName.Splash:
//             return MaterialPageRoute(
//               builder: (context) => const SplashScreen(),
//               settings: settings,
//             );
//       case AppRouterName.Continue:
//             return MaterialPageRoute(
//               builder: (context) => const ContinueScreen(),
//               settings: settings,
//             );  
//       case AppRouterName.SignUp:
//             return MaterialPageRoute(
//               builder: (context) => const SignUpScreen(),
//               settings: settings,
//             ); 
//       case AppRouterName.LogIn:
//             return MaterialPageRoute(
//               builder: (context) => const LogInScreen(),
//               settings: settings,
//             );
//       case AppRouterName.Register:
//             return MaterialPageRoute(
//               builder: (context) => const RegisterScreen(),
//               settings: settings,
//             );
//       case AppRouterName.NavigatorHome:
//             return MaterialPageRoute(
//               builder: (context) => const NavigatorHomeScreen(),
//               settings: settings,
//             );
                                          
//     }
//     return null;
//   }
// }
// class AppRouterName{
//   static const Splash ="/splash";
//   static const Continue="/continue";
//   static const SignUp="/signUp";
//   static const LogIn="/logIn";
//   static const Register="/register";
//   static const NavigatorHome='/navigatorHome';
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/continue/views/continue_screen.dart';
import 'package:music_spotify_app/app/modules/getstarted/views/getstarted_screen.dart';
import 'package:music_spotify_app/app/modules/home/views/navigatorHome_screen.dart';
import 'package:music_spotify_app/app/modules/login/views/login_screen.dart';
import 'package:music_spotify_app/app/modules/musicpage/view/musicpage_screen.dart';
import 'package:music_spotify_app/app/modules/register/views/register_screen.dart';
import 'package:music_spotify_app/app/modules/signup/views/signup_screen.dart';
import 'package:music_spotify_app/app/modules/splash/views/splash_screen.dart';
import 'package:music_spotify_app/generated/widget_tree.dart';

class AppRouter {
  static GetPageRoute? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRouterName.Splash:
        return GetPageRoute(
          page: () => const SplashScreen(),
          settings: settings,
        );
      case AppRouterName.Getstarted:
        return GetPageRoute(
          page: () => const GetStartedScreen(),
          settings: settings,
        );  
      case AppRouterName.Continue:
        return GetPageRoute(
          page: () => const ContinueScreen(),
          settings: settings,
        );
      case AppRouterName.SignUp:
        return GetPageRoute(
          page: () => const SignUpScreen(),
          settings: settings,
        );
      case AppRouterName.LogIn:
        return GetPageRoute(
          page: () => const LogInScreen(),
          settings: settings,
        );
      case AppRouterName.Register:
        return GetPageRoute(
          page: () => const RegisterScreen(),
          settings: settings,
        );
      case AppRouterName.NavigatorHome:
        return GetPageRoute(
          page: () => const NavigatorHomeScreen(),
          settings: settings,
        );
      case AppRouterName.MusicPage:
        return GetPageRoute(
          page: () => const MusicPageScreen(),
          settings: settings,
        );
      case AppRouterName.WidgetTree:
        return GetPageRoute(
          page: () => const WidgetTree(),
          settings: settings,
        );     
    }
    return null;
  }
}

class AppRouterName {
  static const Splash = "/splash";
  static const Getstarted = "/getstarted";
  static const Continue = "/continue";
  static const SignUp = "/signUp";
  static const LogIn = "/logIn";
  static const Register = "/register";
  static const NavigatorHome = '/navigatorHome';
  static const MusicPage ='/musicpage';
  static const WidgetTree='/widgettree';
}