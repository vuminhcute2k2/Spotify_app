import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/login/controller/login_controller.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/app/theme/text_field.dart';
import 'package:music_spotify_app/generated/image_constants.dart';


class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  LoginController loginController =Get.put(LoginController());
  String? emailValue;
  String? passwordValue;
  String? emailError;
  String? passwordError;
  bool _isloading = false;
  var _isObscured;
  @override
  void initState() {
    
    super.initState();
    _isObscured = true;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding:const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Image.asset(
                          ImageConstant.back,
                          width: 26,
                          height: 26,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 50),
                  child: Center(
                      child: Image.asset(
                    'assets/images/img_spotify_logo_rgb_green.png',
                    width: 133,
                    height: 40,
                  )),
                ),
                const Text(
                  "Log In",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'If You Need Any Support ',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Click Here',
                        style:
                            TextStyle(color: Color(0XFF1ED760), fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: Column(
                    children: [
                      // Container(
                      //   margin: const EdgeInsets.only(left: 20, right: 20),
                      //   child: TextField(
                      //     onChanged: (value) {
                      //       emailValue = value;
                      //     },
                      //     controller: emailController,
                      //     keyboardType: TextInputType.emailAddress,
                      //     textInputAction: TextInputAction.next,
                      //     decoration: InputDecoration(
                      //       errorText: emailError,
                      //       prefixIcon: Icon(Icons.email),
                      //       hintText: 'Email',
                      //       hintStyle:
                      //           TextStyle(color: Colors.grey.withOpacity(0.9)),
                      //       enabledBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(24),
                      //         borderSide: const BorderSide(color: Colors.white),
                      //       ),
                      //       focusedBorder: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(24),
                      //         borderSide: const BorderSide(color: Colors.white),
                      //       ),
                      //     ),
                      //     style: const TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      MyTextField(
                        lable: "Email",
                        icons: Icons.email,
                        onChange: loginController.email,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        child: TextField(
                          onChanged: (String value) {
                            passwordValue = value;
                          },
                          obscureText: _isObscured,
                          controller: loginController.password,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            errorText: passwordError,
                            hintText: 'Password',
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.9)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: const BorderSide(color: Colors.white),
                            ),
                            suffixIcon: IconButton(
                              padding:
                                  const EdgeInsetsDirectional.only(end: 12.0),
                              icon: _isObscured
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          //obscureText: true,
                          obscuringCharacter: '*',
                        ),
                      ),
                      const Padding(padding: EdgeInsets.symmetric(vertical: 5)),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, top: 10, bottom: 15),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Forgot password?',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          loginController.onLogin();
                          // Navigator.pushNamed(context, AppRouterName.NavigatorHome);
                        },
                        child: Container(
                          width: 350,
                          height: 75,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: Color(0XFF42C83C),
                            borderRadius: BorderRadius.circular(80),
                          ),
                          child: const Center(
                            child: Text(
                              'Log In',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              top: 7,
                              bottom: 6,
                            ),
                            child: SizedBox(
                              width: 150,
                              child: Divider(),
                            ),
                          ),
                          Text(
                            "Or",
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              top: 7,
                              bottom: 6,
                            ),
                            child: SizedBox(
                              width: 150,
                              child: Divider(),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 30,top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 100,
                                height: 48,
                                padding:const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  //color: Colors.white.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Image.asset(
                                  ImageConstant.imgFacebook,
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 100,
                                height: 48,
                                padding:const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  ImageConstant.imgGoogle,
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 100,
                                height: 48,
                                padding:const EdgeInsets.all(6.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: SvgPicture.asset(
                                  ImageConstant.imgApple,
                                  width: 26,
                                  height: 26,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("don't have an account? ",style: TextStyle(color: Colors.white),),
                          GestureDetector(
                            onTap: (){
                             // Navigator.pushNamed(context, AppRouterName.Register);
                             Get.toNamed(AppRouterName.Register);
                            },
                            child:const Text('Register',style: TextStyle(color: Color(0XFFD7BD1E)),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
