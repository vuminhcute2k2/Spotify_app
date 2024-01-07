import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/common/authentication.dart';

class RegisterController extends GetxController{
  TextEditingController fullname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController repeat = TextEditingController();
  final FirebaseAuth _auth =FirebaseAuth.instance;
  
void onRegister() async {
    // Gọi hàm signUpUser từ Auth controller
    await Auth().signUpUser(
      email: email.text.trim(),
      fullname: fullname.text.trim(),
      password: password.text.trim(),
      image: '',
      about: '',

    );

    // Lấy giá trị của biến error từ Auth controller
    String errorMessage = Auth().error.value;

    if (errorMessage.isEmpty) {
      // Đăng ký thành công,
      Get.toNamed(AppRouterName.NavigatorHome);
    } else {
      // Hiển thị thông báo lỗi
      Get.snackbar('Error', errorMessage);
    }
  }


}