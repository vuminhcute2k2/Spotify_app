// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final List<ListMostlyPlayed> listMostlyplayed = [
    ListMostlyPlayed(
        imgMostlyPlayed:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameSong: 'Dekat Di Hati',
        author: 'RAN'),
    ListMostlyPlayed(
        imgMostlyPlayed:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameSong: 'Dekat Di Hati',
        author: 'RAN'),
    ListMostlyPlayed(
        imgMostlyPlayed:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameSong: 'Dekat Di Hati',
        author: 'RAN'),
    ListMostlyPlayed(
        imgMostlyPlayed:
            'https://cdn.tgdd.vn/Files/2021/08/11/1374600/lofi-la-gi-trao-luu-nhac-lofi-co-gi-dac-biet-top-2.jpg',
        nameSong: 'Dekat Di Hati',
        author: 'RAN'),                
  ];
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
        child: SingleChildScrollView(
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
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/147/147142.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Text(
                      'Fauzian Ahmad',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    Text(
                      'fauzianahmad04@gmail.com',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 14),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 20),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 2),
                                child: Text(
                                  'Followers',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                              Text(
                                '129',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Following',
                                style:
                                    TextStyle(color: Colors.white, fontSize: 12),
                              ),
                              Text(
                                '129',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 80,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                child: SvgPicture.asset(
                              ImageConstant.imgVuesaxOutlineProfileAdd,
                            )),
                          ),
                          const Text(
                            'Find friend',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Container(
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                child: SvgPicture.asset(
                              ImageConstant.imgVuesaxDirectbox,
                            )),
                          ),
                          const Text(
                            'Share',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 0.03,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5), // Màu của shadow
                      spreadRadius: 5, // Bản rộng của shadow
                      blurRadius: 5, // Độ mờ của shadow
                      offset: Offset(0, 3), // Vị trí của shadow
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.0),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Mostly played",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Container(
                    width: double.infinity,
                    height: 400,
                    child: ListView.builder(
                      itemCount: listMostlyplayed.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                //color: Colors.grey
                                border: Border.all(width: 0.5)),
                            child: Container(
                              margin:const EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        listMostlyplayed[index].imgMostlyPlayed,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 30),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          listMostlyplayed[index].nameSong,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          listMostlyplayed[index].author,
                                          style: const TextStyle(
                                              color: Colors.white, fontSize: 14),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.more_vert,
                                    color: Color(0XFF1ED760),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class ListMostlyPlayed {
  String imgMostlyPlayed;
  String nameSong;
  String author;
  ListMostlyPlayed({
    required this.imgMostlyPlayed,
    required this.nameSong,
    required this.author,
  });
}
