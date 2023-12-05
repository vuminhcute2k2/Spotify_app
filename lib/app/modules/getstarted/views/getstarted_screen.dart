import 'package:flutter/material.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
//import 'package:spotify_app/routers/app_router.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 150,),
                Center(child: Image.asset('assets/images/img_spotify_logo_rgb_green.png',width: 133,height: 40,)),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width:double.infinity,
                      height: 500,
                      margin:const  EdgeInsets.only(bottom: 350),
                      // Sử dụng BoxDecoration để đặt background image
                      decoration:const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/background_spotify.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Nội dung bạn muốn đặt trên background image
                    // Ví dụ: Text, button, v.v.
                     SizedBox(
                      child: Column(
                        children: [
                          const Text(
                            'Music for everyone.',
                            style: TextStyle(
                              color: Color(0XFF1ED760),
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(
                            width: 330,
                            child: Text(
                              'Nulla Lorem mollit cupidatat irure. Laborum magna nulla duis ullamco cillum dolor. Voluptate exercitation incididunt aliquip deserunt reprehenderit elit laborum. ',
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                              ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, AppRouterName.Continue);
                            },
                            child: Container(
                              width: 350,
                              height: 75,
                              alignment: Alignment.center,
                              padding:const EdgeInsets.symmetric(vertical: 16),
                              margin: const EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                              color: Color(0XFF42C83C),
                              borderRadius: BorderRadius.circular(80),
                              ),
                              child:const Center(
                                child: Text(
                                  'Get started',
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                
                                    
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            
              ],
            ),
          ),
        ) ,
      ),
    );
  }
}