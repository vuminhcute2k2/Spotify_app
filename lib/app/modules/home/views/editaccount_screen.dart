

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/home/controller/profile_controller.dart';
import 'package:music_spotify_app/app/modules/home/views/profile_screen.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/common/authentication.dart';
import 'package:music_spotify_app/service/store_service.dart';
import 'package:velocity_x/velocity_x.dart';

// ... (imports)

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    // khởi tạo để lấy giá trị currentUser từ authentication
    Auth auth = Auth();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: "Edit Account".text.color(Colors.white).semiBold.make(),
        backgroundColor: Colors.transparent,
        leading: IconButton(
            icon:const Icon(Icons.backspace_rounded,color: Colors.white,),
            onPressed: () {
              Get.back();
            },
          ),
        elevation: 0.0,
         actions: [
          TextButton(
            onPressed: () async {
              // Put upload img method here
              if (controller.imgpath.isEmpty) {
                controller.updateProfile(context);
                Get.offAllNamed(AppRouterName.NavigatorHome);
              } else {
                await controller.uploadImage();
                controller.updateProfile(context);
                Get.offAllNamed(AppRouterName.NavigatorHome);
                
              }
            },
            child: "Save".text.white.semiBold.make(),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: FutureBuilder(
          future: StoreServices.getUser(auth.currentUser!.uid),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Nếu dữ liệu đang được tải, hiển thị tiến trình chờ
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
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
                controller.nameController.text = data['fullname'];
                controller.emailController.text = data['email'];
                controller.aboutController.text = data['about'];

                return Column(
                  children: [
                    Obx(() => CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white,
                      child: Stack(
                        children: [
                          controller.imgpath.isEmpty && data['image'] ==''
                                ? Image.network(
                                    "https://i.pinimg.com/736x/ff/a0/9a/ffa09aec412db3f54deadf1b3781de2a.jpg",
                                    color: Colors.white,
                                  )
                                //when imgpath is not empty means file is selected
                                : controller.imgpath.isNotEmpty ? Image.file(File(controller.imgpath.value))
                                    .box
                                    .roundedFull
                                    .clip(Clip.antiAlias)
                                    .make():
                                    //show network img form document
                                    Image.network(data['image'],).box.roundedFull.clip(Clip.antiAlias).make(),
                          Positioned(
                            right: 0,
                            bottom: 20,
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.camera_alt_rounded,
                              ).onTap(() {
                                Get.dialog(pickerDialog(context, controller));
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(color: Colors.white, height: 1),
                    const SizedBox(height: 10),
                     ListTile(
                    leading: const Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: TextFormField(
                      controller: controller.nameController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        label: "Full Name".text.white.make(),
                        isDense: true,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                    ListTile(
                    leading: const Icon(
                      Icons.info,
                      color: Colors.white,
                    ),
                    title: TextFormField(
                      controller: controller.aboutController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        label: "About".text.white.make(),
                        isDense: true,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                    title: TextFormField(
                      controller: controller.emailController,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      readOnly: true,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        label: "Email".text.white.make(),
                        isDense: true,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  ],
                );
              } else {
                // Trường 'image' không tồn tại trong dữ liệu hoặc data không phải là một Map.
                // Thực hiện xử lý tùy thuộc vào yêu cầu của bạn.
                return const Center(
                  child: Text('Image not available',style: TextStyle(color: Colors.white),),
                );
              }
            }
          },
        ),
      ),
    );
  }
}
