import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:music_spotify_app/generated/image_constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarSize = screenWidth * 0.25;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color(0XFF3333333),
        centerTitle: true,
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.white,
              ))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: screenWidth * 0.6,
              decoration: const BoxDecoration(
                  //border: Border(bottom:BorderSide(color: Color(0XFF333333))),
                  color: const Color(0XFF3333333),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(38),
                      bottomRight: Radius.circular(38))),
              child: Column(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    child: ClipRRect(
                      child: Image.network('https://cdn-icons-png.flaticon.com/512/147/147142.png',fit: BoxFit.cover,),
                    ),
                  ),
                  Text('Fauzian Ahmad',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),
                  Text('fauzianahmad04@gmail.com',style: TextStyle(color: Colors.white,fontWeight: FontWeight.normal,fontSize: 14),),
                  Container(
                    margin:const EdgeInsets.symmetric(horizontal: 100,vertical: 20),
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 2),
                              child: Text('Followers',style: TextStyle(color: Colors.white,fontSize: 12),),
                            ),
                            Text('129',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                        Column(
                          children: [
                            Text('Following',style: TextStyle(color: Colors.white,fontSize: 12),),
                            Text('129',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            // Container(
            //   child: Row(
            //     children: [
            //       Column(
            //         children: [
            //           GestureDetector(
            //             child:SvgPicture.asset(ImageConstant.imgVuesaxOutlineProfileAdd,),
            //           ),
            //         ],
            //       ),
            //       Column(
            //         children: [
            //           GestureDetector(
            //            child: SvgPicture.asset(ImageConstant.imgVuesaxDirectbox),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
