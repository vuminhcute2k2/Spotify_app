import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/generated/image_constants.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin:const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
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
                // const SizedBox(
                //   height: 100,
                // ),
                Center(
                    child: Image.asset(
                  'assets/images/img_spotify_logo_rgb_green.png',
                  width: 133,
                  height: 40,
                )),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 500,
                      margin: const EdgeInsets.only(bottom: 350),
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage('assets/images/background_spotify.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      margin:const EdgeInsets.symmetric(horizontal: 15),
                      child: SizedBox(
                        child: Column(
                          children: [
                            
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(context,AppRouterName.LogIn);
                                Get.offNamed(AppRouterName.LogIn);
                              },
                              child: Container(
                                width: 350,
                                height: 60,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  color: Color(0XFF42C83C),
                                  borderRadius: BorderRadius.circular(80),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Sign up free',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(
                                //     context, AppRouterName.Information);
                              },
                              child: Container(
                                width: 350,
                                height: 60,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20,top: 10),
                                decoration: BoxDecoration(
                                  //color: Colors.white.withOpacity(0),
                                  borderRadius: BorderRadius.circular(80),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin:const EdgeInsets.only(left: 20),
                                      child:const Icon(Icons.phone_iphone_outlined,color: Colors.white,),),
                                    const Text(
                                      'Continue with phone number',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(
                                //     context, AppRouterName.Information);
                              },
                              child: Container(
                                width: 350,
                                height: 60,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20,top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0),
                                  borderRadius: BorderRadius.circular(80),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin:const EdgeInsets.only(left: 20),
                                      child: Image.asset(ImageConstant.imgGoogle,height: 28,width: 29,)),
                                    const Text(
                                      'Continue with Google',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.pushNamed(
                                //     context, AppRouterName.Information);
                              },
                              child: Container(
                                width: 350,
                                height: 60,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                margin:
                                    const EdgeInsets.only(left: 20, right: 20,top: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0),
                                  borderRadius: BorderRadius.circular(80),
                                  border: Border.all(color: Colors.white),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin:const EdgeInsets.only(left: 20),
                                      child: Image.asset(ImageConstant.imgFacebook,height: 28,width: 29,)),
                                    const Text(
                                      'Continue with facebook',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      width: 40,
                                    ),
                                    
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
