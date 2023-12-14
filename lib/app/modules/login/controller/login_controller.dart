import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/home/views/navigatorhome_screen.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/common/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  SharedPreferences? prefs;
  @override
  void onInit() {
    super.onInit();
  }
  void initSharedPref() async {
    // Doi shared prefs nay phai khoi tao xong
    prefs = await SharedPreferences.getInstance();
    //
  }
  void loginUser() async {
    try {
      String res = await Auth().loginUser(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (res == "success") {
        Get.toNamed(AppRouterName.NavigatorHome);
      } else {
        // Hiển thị thông báo lỗi
        Get.defaultDialog(
          title: "Thông báo",
          middleText: "Sai tài khoản hoặc mật khẩu",
          confirm: ElevatedButton(
            onPressed: () => Get.back(),
            child: Text("Đóng"),
          ),
        );
      }
    } catch (e) {
      print("Error: $e");
    }

    // validateInput();
  }

//   void validateInput() {
//     if (emailController.text.length < 6 &&
//         passwordController.text.length < 6 &&
//         emailController.text.isNotEmpty &&
//         passwordController.text.isNotEmpty) {
//       emailError.value = "Email không được nhỏ hơn 6 ký tự";
//       passwordError.value = "Password không được nhỏ hơn 6 kí tự";
//     }

//     if (emailController.text.length >= 6 &&
//         passwordController.text.length >= 6) {
//       emailError.value = null;
//       passwordError.value = null;
//       // Các giá trị khác bạn có thể set ở đây nếu cần
//     }

//     if (emailController.text.isEmpty) {
//       emailError.value = "Email không được để rỗng";
//     }

//     if (passwordController.text.isEmpty) {
//       passwordError.value = "Password không được để rỗng";
//     }

//     if (emailController.text.contains(" ") ||
//         passwordController.text.contains(" ")) {
//       emailError.value = "Email không được để dấu cách";
//       passwordError.value = "Password không được để dấu cách";
//     }
//   }
}
