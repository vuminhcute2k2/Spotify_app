import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/home/controller/profile_controller.dart';
import 'package:music_spotify_app/app/modules/home/views/navigatorhome_screen.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/common/authentication.dart';
import 'package:music_spotify_app/model/spotifyAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  SharedPreferences? prefs;
  final SpotifyApi _spotifyApi = SpotifyApi();
  final String clientId = 'ff6dfa31695249239b64551801a0d7a6';
  final String redirectUri = 'http://localhost:8080/callback';
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
        await _loginWithSpotify();
        updateUserData();
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
  }
  Future<void> _loginWithSpotify() async {
  print("Hàm _loginWithSpotify được gọi."); // Log kiểm tra

  final url = 'https://accounts.spotify.com/authorize?client_id=$clientId&redirect_uri=$redirectUri&response_type=code';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    print("Nhận được phản hồi từ Spotify."); // Log phản hồi
    final code = response.body;
    final accessToken = await _spotifyApi.getAccessToken(code);
    if (accessToken != null) {
      await FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.uid).set({
        'access_token': accessToken,
      });
      print("Access token được lưu thành công.");
    }
  } else {
    print("Lỗi: Không nhận được phản hồi thành công từ Spotify.");
  }
}

  // Hàm này để cập nhật trạng thái người dùng
  void updateUserData() {
    // Gọi hàm cập nhật người dùng trong ProfileController hoặc nơi bạn lưu trữ trạng thái người dùng
    ProfileController profileController = Get.find();
    profileController.loadUserData();
   // profileController.update();
  }

}
