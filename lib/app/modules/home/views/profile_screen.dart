// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_spotify_app/app/modules/home/controller/profile_controller.dart';
import 'package:music_spotify_app/app/modules/home/views/editaccount_screen.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/common/authentication.dart';

import 'package:music_spotify_app/generated/image_constants.dart';
import 'package:music_spotify_app/service/store_service.dart';
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
  Auth auth = Auth();
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
                       Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            child: FutureBuilder(
              future: StoreServices.getUser(auth.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Nếu dữ liệu đang được tải, hiển thị tiến trình chờ
                  return const Center(
                    child: CircularProgressIndicator(
                        // valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                  );
                } else if (snapshot.hasError) {
                  // Nếu có lỗi khi tải dữ liệu, hiển thị thông báo lỗi
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  // Nếu không có dữ liệu, hiển thị thông báo không có dữ liệu
                  return const Center(
                    child: Text('No data available'),
                  );
                } else {
                  var data = snapshot.data!.docs[0].data();
                  print("xin chao:${data}");
                  if (data is Map && data.containsKey('image')) {
                    var imageUrl = data['image'];
                    print(currentUser!.uid);

                    return Column(
                      children: [
                        Obx(
                          () => Column(
                            children: [
                              profileController.imgpath.isEmpty &&
                                      data['image'] == ''
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundColor: null,
                                      child: Image.network(
                                        "https://i.pinimg.com/736x/ff/a0/9a/ffa09aec412db3f54deadf1b3781de2a.jpg",
                                        //color: Colors.white,
                                      )
                                          .box
                                          .roundedFull
                                          .clip(Clip.antiAlias)
                                          .make(),
                                    )
                                  //when imgpath is not empty means file is selected
                                  : profileController.imgpath.isNotEmpty
                                      ? Image.file(File(
                                              profileController.imgpath.value))
                                          .box
                                          .roundedFull
                                          .clip(Clip.antiAlias)
                                          .make()
                                      :
                                      //show network img form document
                                      CircleAvatar(
                                          radius: 60,
                                          backgroundColor: null,
                                          child: Image.network(
                                            data['image'],
                                          )
                                              .box
                                              .roundedFull
                                              .clip(Clip.antiAlias)
                                              .make()),
                              const SizedBox(height: 5,),               
                              SizedBox(
                                  child: Text(
                                data['fullname'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                              SizedBox(
                                child: Text(data['email'],style:const TextStyle(color: Colors.white,fontSize: 14),),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Trường 'image' không tồn tại trong dữ liệu hoặc data không phải là một Map.
                    // Thực hiện xử lý tùy thuộc vào yêu cầu của bạn.
                    return const Center(
                      child: Text(
                        'Image not available',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                }
              },
            ),
          ),
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
  Auth auth = Auth();
  ProfileController drawerController = Get.put(ProfileController());
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
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(12.0),
            child: FutureBuilder(
              future: StoreServices.getUser(auth.currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Nếu dữ liệu đang được tải, hiển thị tiến trình chờ
                  return const Center(
                    child: CircularProgressIndicator(
                        // valueColor: AlwaysStoppedAnimation(Colors.white),
                        ),
                  );
                } else if (snapshot.hasError) {
                  // Nếu có lỗi khi tải dữ liệu, hiển thị thông báo lỗi
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  // Nếu không có dữ liệu, hiển thị thông báo không có dữ liệu
                  return const Center(
                    child: Text('No data available'),
                  );
                } else {
                  var data = snapshot.data!.docs[0].data();
                  print("xin chao:${data}");
                  if (data is Map && data.containsKey('image')) {
                    var imageUrl = data['image'];
                    print(currentUser!.uid);
                    return Column(
                      children: [
                        Obx(
                          () => Column(
                            children: [
                              drawerController.imgpath.isEmpty &&
                                      data['image'] == ''
                                  ? CircleAvatar(
                                      radius: 60,
                                      backgroundColor: null,
                                      child: Image.network(
                                        "https://i.pinimg.com/736x/ff/a0/9a/ffa09aec412db3f54deadf1b3781de2a.jpg",
                                        //color: Colors.white,
                                      )
                                          .box
                                          .roundedFull
                                          .clip(Clip.antiAlias)
                                          .make(),
                                    )
                                  //when imgpath is not empty means file is selected
                                  : drawerController.imgpath.isNotEmpty
                                      ? Image.file(File(
                                              drawerController.imgpath.value))
                                          .box
                                          .roundedFull
                                          .clip(Clip.antiAlias)
                                          .make()
                                      :
                                      //show network img form document
                                      CircleAvatar(
                                          radius: 60,
                                          backgroundColor: null,
                                          child: Image.network(
                                            data['image'],
                                          )
                                              .box
                                              .roundedFull
                                              .clip(Clip.antiAlias)
                                              .make()),
                              SizedBox(
                                  child: Text(
                                data['fullname'],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Trường 'image' không tồn tại trong dữ liệu hoặc data không phải là một Map.
                    return const Center(
                      child: Text(
                        'Image not available',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                }
              },
            ),
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
          Spacer(),
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
              Get.delete<ProfileController>();
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
const 
    account = "Account",
    soucre = "Select soucre",
    gallery = "Gallery",
    camera = "Camera",
    cancel = "Cancel",
    loggedin = "Logged in",
    loggedout = "Logged out",
    editaccount = "Edit Account",
    invite = "Invite a friend",
    logout = "Logout",
    settings = "Settings",
    continuneText = "Continune",
    slogan = "join the\nrevolution\ntoday.";
const drawerListTitles = [
  "Acount",
  "Friends",
  "Notifications",
  "Data and Storage",
  "Help"
];
