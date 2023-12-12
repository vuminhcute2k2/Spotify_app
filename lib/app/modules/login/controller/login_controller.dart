import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/home/views/navigatorhome_screen.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';

class LoginController extends GetxController{
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
  void onLogin(){
    sigIn(email.text, password.text);
  }


  Future<void> sigIn(String email,String password) async
  {
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.toNamed(AppRouterName.NavigatorHome);
      Fluttertoast.showToast(
        msg: "Đăng nhập thành công!",
        backgroundColor: Colors.green[600]
      );
    }on FirebaseAuthException catch(e){
      if(e.code=='user-not-found'){
        print('email id does not exists');
      }else if(e.code=='wrong-password'){
        print('Wrong password');
      }
    }
  }

}