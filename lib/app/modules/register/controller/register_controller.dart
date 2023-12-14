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
  

  // void onRegister(){
  //   print(fullname.text);
  //   print(email.text);
  //   print(password.text);
  //   print(repeat.text);
  //   print("Register");
  //   createAccount(email.text, password.text);
  // }
  
//   Future<void> createAccount(String email, String password) async {
//   try {
//     await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     print('Account created successfully');
//     return Get.toNamed(AppRouterName.NavigatorHome); // Trả về null nếu không có lỗi
//   } on FirebaseAuthException catch (e) {
//     print('Error creating account: ${e.message}');

//     // Xử lý từng loại lỗi cụ thể
//     if (e.code == 'weak-password') {
//       Fluttertoast.showToast(msg: 'Weak password');
//     } else if (e.code == 'email-already-in-use') {
//       Fluttertoast.showToast(msg: 'Email already exists. Please log in.');
//     } else {
//       // Xử lý các loại lỗi khác nếu cần
//       Fluttertoast.showToast(msg: 'Error creating account. Please try again later.');
//     }
//   } catch (e) {
//     print('Unexpected error: $e');
//     Fluttertoast.showToast(msg: 'Unexpected error occurred. Please try again later.');
//   }
// }
void onRegister() async {
    // Gọi hàm signUpUser từ Auth controller
    await Auth().signUpUser(
      email: email.text.trim(),
      fullname: fullname.text.trim(),
      password: password.text.trim(),
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