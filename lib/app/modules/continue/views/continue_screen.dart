import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/generated/image_constants.dart';

class ContinueScreen extends StatefulWidget {
  const ContinueScreen({super.key});

  @override
  State<ContinueScreen> createState() => _ContinueScreenState();
}

class _ContinueScreenState extends State<ContinueScreen> {
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
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      child: Column(
                        children: [
                          Text(
                            'Choose Mode',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(
                                            0.5), // Độ trong suốt của màu xanh
                                        borderRadius: BorderRadius.circular(80),
                                      ),
                                      child: SvgPicture.asset(
                                        ImageConstant.imgHiconLinearGray200,
                                        width: 26,
                                        height: 26,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Dark mode',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(
                                            0.5), 
                                        borderRadius: BorderRadius.circular(80),
                                      ),
                                      child: SvgPicture.asset(
                                        ImageConstant.imgHiconLinear,
                                        width: 26,
                                        height: 26,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Light mode',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context,AppRouterName.SignUp);
                            },
                            child: Container(
                              width: 350,
                              height: 75,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                color: Color(0XFF1ED760),
                                borderRadius: BorderRadius.circular(80),
                              ),
                              child: const Center(
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
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
    );
  }
}
