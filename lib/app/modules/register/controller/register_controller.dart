import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';

class RegisterController extends GetxController{
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeat = TextEditingController();
  final FirebaseAuth _auth =FirebaseAuth.instance;

  void onRegister(){
    print(fullname.text);
    print(email.text);
    print(password.text);
    print(repeat.text);
    print("Register");
    createAccount(email.text, password.text);
  }
  // Future<String> createAccount(String email,String password) async{
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
  //     print('Account create');
  //     return "Account create";
  //   }on FirebaseAuthException catch(e){
  //     if (e.code=='weak-password') 
  //     {
  //       print('weak password');
  //       return 'weak password';
  //     }
  //     else if(e.code=='email-already-in-use'){
  //       print('Emai; Already exists Login Please !');
  //       return 'Emai; Already exists Login Please !';
  //     }
  //     return "";
  //   }
  //    catch (e) {
  //     print(e);
  //     return "";
  //   }
  // }
  Future<void> createAccount(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    print('Account created successfully');
    return Get.toNamed(AppRouterName.NavigatorHome); // Trả về null nếu không có lỗi
  } on FirebaseAuthException catch (e) {
    print('Error creating account: ${e.message}');

    // Xử lý từng loại lỗi cụ thể
    if (e.code == 'weak-password') {
      Fluttertoast.showToast(msg: 'Weak password');
    } else if (e.code == 'email-already-in-use') {
      Fluttertoast.showToast(msg: 'Email already exists. Please log in.');
    } else {
      // Xử lý các loại lỗi khác nếu cần
      Fluttertoast.showToast(msg: 'Error creating account. Please try again later.');
    }
  } catch (e) {
    print('Unexpected error: $e');
    Fluttertoast.showToast(msg: 'Unexpected error occurred. Please try again later.');
  }
}
}