// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_spotify_app/app/modules/home/controller/profile_controller.dart';
import 'package:music_spotify_app/app/modules/home/views/editaccount_screen.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/common/authentication.dart';

import 'package:music_spotify_app/generated/image_constants.dart';
import 'package:velocity_x/velocity_x.dart';

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
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double avatarSize = screenWidth * 0.25;
    return Scaffold(
      drawer: drawer(),
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: const Color(0XFF3333333),
        centerTitle: true,
        title: const Text(
          'Profil',
          style: TextStyle(color: Colors.white),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {

        //       },
        //       icon: const Icon(
        //         Icons.more_horiz,
        //         color: Colors.white,
        //       ))
        // ],
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
                child: Container(
                  child: Column(
                    children: [
                      // Obx(() => Container(
                      //   width: 90,
                      //   height: 90,
                      //   child: ClipRRect(
                      //     child: Image.network(
                      //       'https://cdn-icons-png.flaticon.com/512/147/147142.png',
                      //       fit: BoxFit.cover,
                      //     ) ,
                      //   ),
                      // ),
                      // ),
                      GetBuilder<ProfileController>(
                        builder: (controller) {
                          return CircleAvatar(
                            radius: 80,
                            backgroundColor: Colors.white,
                            child: Stack(
                              children: [
                                controller.imglink.isNotEmpty
                                    ? Image.network(
                                        controller.imglink,
                                        fit: BoxFit.cover,
                                      )
                                        .box
                                        .roundedFull
                                        .clip(Clip.antiAlias)
                                        .make()
                                    : Image.network(
                                        'https://cdn-icons-png.flaticon.com/512/147/147142.png',
                                        fit: BoxFit.cover,
                                      )
                                        .box
                                        .roundedFull
                                        .clip(Clip.antiAlias)
                                        .make(),
                                Positioned(
                                  right: 0,
                                  bottom: 20,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.white,
                                    ).onTap(() {
                                      Get.dialog(
                                          pickerDialog(context, controller));
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )

                      // Obx(() => CircleAvatar(
                      //     radius: 80,
                      //     backgroundColor: Colors.white,
                      //     child: Stack(
                      //       children: [
                      //         //when imgpath is empty
                      //         profileController.imgpath.isEmpty && data['image_url'] ==''
                      //             ? Image.network(
                      //       'https://cdn-icons-png.flaticon.com/512/147/147142.png',fit: BoxFit.cover, )
                      //             //when imgpath is not empty means file is selected
                      //             : profileController.imgpath.isNotEmpty ? Image.file(File(profileController.imgpath.value))
                      //                 .box
                      //                 .roundedFull
                      //                 .clip(Clip.antiAlias)
                      //                 .make():
                      //                 //show network img form document
                      //                 Image.network(data['image_url'],).box.roundedFull.clip(Clip.antiAlias).make(),
                      //         Positioned(
                      //           right: 0,
                      //           bottom: 20,
                      //           //show dialog on tap of this button
                      //           child: CircleAvatar(
                      //             backgroundColor:Colors.white,
                      //             child: Icon(
                      //               Icons.camera_alt_rounded,
                      //               color: Colors.white,
                      //               //using velocityX onTap here
                      //             ).onTap(() {
                      //               //using getx dialog and passing our widget
                      //               //passing context and our controller to the widget
                      //               Get.dialog(pickerDialog(context, profileController));
                      //             }),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),),
                      // Text(
                      //   'Fauzian Ahmad',
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 20),
                      // ),
                      // Text(
                      //   'fauzianahmad04@gmail.com',
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.normal,
                      //       fontSize: 14),
                      // ),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(
                      //       horizontal: 100, vertical: 20),
                      //   child: const Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         children: [
                      //           Padding(
                      //             padding: EdgeInsets.only(bottom: 2),
                      //             child: Text(
                      //               'Followers',
                      //               style: TextStyle(
                      //                   color: Colors.white, fontSize: 12),
                      //             ),
                      //           ),
                      //           Text(
                      //             '129',
                      //             style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold),
                      //           )
                      //         ],
                      //       ),
                      //       Column(
                      //         children: [
                      //           Text(
                      //             'Following',
                      //             style:
                      //                 TextStyle(color: Colors.white, fontSize: 12),
                      //           ),
                      //           Text(
                      //             '129',
                      //             style: TextStyle(
                      //                 color: Colors.white,
                      //                 fontSize: 20,
                      //                 fontWeight: FontWeight.bold),
                      //           )
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 65,
                                      height: 65,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          listMostlyplayed[index]
                                              .imgMostlyPlayed,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                color: Colors.white,
                                                fontSize: 14),
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

Widget drawer() {
  return Drawer(
    backgroundColor: Color(0XFF333333),
    shape: const RoundedRectangleBorder(
      borderRadius:
          BorderRadiusDirectional.horizontal(end: Radius.circular(25)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.backpack_rounded,
              color: Colors.white,
            ).onTap(() {
              Get.back();
            }),
            title: settings.text.semiBold.white.make(),
          ),
          const SizedBox(
            height: 20,
          ),
          CircleAvatar(
            radius: 45,
            backgroundColor: Colors.blue,
            child: Image.asset(
              "assets/images/img_adele.png",
            ),
            // child: Image.network(
            //   HomeController.instance.userImage,fit: BoxFit.cover,
            // ).box.roundedFull.clip(Clip.antiAlias).make(),
          ),
          const SizedBox(
            height: 10,
          ),
          //HomeController.instance.username.text.semiBold.white.size(16).make(),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Colors.black,
            height: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          ListView(
            shrinkWrap: true,
            children: List.generate(
              drawerIconsList.length,
              (index) => ListTile(
                onTap: () {
                  switch (index) {
                    case 0:
                      Get.to(() => const EditAccountScreen(),
                          transition: Transition.downToUp);
                      break;
                    default:
                  }
                },
                leading: Icon(
                  drawerIconsList[index],
                  color: Colors.white,
                ),
                title: drawerListTitles[index].text.semiBold.white.make(),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: Colors.black,
            height: 1,
          ),
          const SizedBox(
            height: 10,
          ),
          ListTile(
            leading: const Icon(
              inviteIcon,
              color: Colors.white,
            ),
            title: invite.text.semiBold.white.make(),
          ),
          Spacer(),
          ListTile(
            onTap: () async {
              await Auth().logout();
              Get.offAllNamed(AppRouterName.LogIn);
            },
            leading: const Icon(
              logoutIcon,
              color: Colors.white,
            ),
            title: logout.text.semiBold.white.make(),
          )
        ],
      ),
    ),
  );
}

Widget pickerDialog(context, controller) {
  //setting listicons and titles
  var listTile = [camera, gallery, cancel];
  var icons = [
    Icons.camera_alt_rounded,
    Icons.photo_size_select_large_rounded,
    Icons.cancel_rounded
  ];
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Container(
      padding: const EdgeInsets.all(12),
      color: Color(0XFF333333),
      child: Column(
        //setting size to min
        mainAxisSize: MainAxisSize.min,
        children: [
          soucre.text.semiBold.white.make(),
          Divider(),
          const SizedBox(
            height: 10,
          ),
          ListView(
            shrinkWrap: true,
            children: List.generate(
                3,
                (index) => ListTile(
                      onTap: () {
                        //setting ontap according to index
                        switch (index) {
                          //ontap of camera
                          case 0:
                            //providing camera source
                            Get.back();
                            controller.pickImage(context, ImageSource.camera);
                            break;
                          //ontap of gallery
                          case 1:
                            //providing gallery source
                            Get.back();
                            controller.pickImage(context, ImageSource.gallery);
                            break;
                          //ontap of cancel
                          case 2:
                            //close dialog
                            Get.back();
                            break;
                        }
                      },
                      //getting icons from our list
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                      ),
                      //getting titles from our list
                      title: listTile[index].text.white.make(),
                    )),
          ),
        ],
      ),
    ),
  );
}

const settingsIcon = Icons.settings,
    accountIcon = Icons.key_rounded,
    friendsIcon = Icons.people,
    notificationIcon = Icons.notifications_rounded,
    dataIcon = Icons.storage_rounded,
    helpIcon = Icons.help,
    inviteIcon = Icons.emoji_people_rounded,
    logoutIcon = Icons.logout_rounded,
    backIcon = Icons.arrow_back_ios_new_rounded;
var drawerIconsList = <IconData>[
  accountIcon,
  friendsIcon,
  notificationIcon,
  dataIcon,
  helpIcon
];
const listOfFeatures = [
  "Fast",
  "Powerful",
  "Secure",
  "Private",
  "Unlimited",
  "Synced",
  "Rellable"
];
const appname = "Whatschat",
    account = "Account",
    chats = "Chats",
    status = "Status",
    soucre = "Select soucre",
    gallery = "Gallery",
    camera = "Camera",
    cancel = "Cancel",
    recentupdates = "Recent updates",
    loggedin = "Logged in",
    loggedout = "Logged out",
    editaccount = "Edit Account",
    invite = "Invite a friend",
    logout = "Logout",
    settings = "Settings",
    connnectingLives = "connecting lives..",
    poweredby = "Desgiend & Developed by Vuminh",
    cont = "Start Messaging",
    otp = "We will send an SMS with a confirmation code to your phone number",
    continuneText = "Continune",
    namesub =
        "This is not your username or pin. This name will be visibale to your WhatsChat friends .",
    letsconnect = "Let's Connect",
    slogan = "join the\nrevolution\ntoday.";
const drawerListTitles = [
  "Acount",
  "Friends",
  "Notifications",
  "Data and Storage",
  "Help"
];
