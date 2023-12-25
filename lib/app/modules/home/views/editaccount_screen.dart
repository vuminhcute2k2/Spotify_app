import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/home/controller/profile_controller.dart';
import 'package:music_spotify_app/app/modules/home/views/profile_screen.dart';
import 'package:music_spotify_app/service/store_service.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:music_spotify_app/common/authentication.dart';

class EditAccountScreen extends StatelessWidget {
  const EditAccountScreen({Key? key});
  
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: editaccount.text.color(Colors.white).semiBold.make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          //save button to update profile
          TextButton(
              onPressed: () async{
                //put upload img method here 
                if(controller.imgpath.isEmpty){
                  //if img is selected then only update the values
                  controller.updateProfile(context);
                }else{
                  //update both profile img and value
                  //let wait for our img to be upload first 
                  await controller.uploadImage();
                  controller.updateProfile(context);
                }
              },
              child: "Save".text.white.semiBold.make()),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        //init futureBuilder
        child: FutureBuilder(
            //padding current user id  to the function to get the user document in firestore
            future: StoreServices.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              //if data in loaded show the widget
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                //setting snapshot into a variable for each access
                //here docs[0] because it will contain only one document
                var data = snapshot.data!.docs[0];
                //setting values to the text controller
                controller.nameController.text = data['fullname'];
                controller.emailController.text = data['email'];
                //controller.aboutController.text = data['about'];

                return Column(
                  children: [
                    Obx(
                      () => CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white,
                        child: Stack(
                          children: [
                            //when imgpath is empty
                            controller.imgpath.isEmpty && data['image'] ==''
                                ? ClipOval(
                                  child: Image.asset(
                                    "assets/images/img_adele.png",
                                      // color: Colors.white,
                                      
                                    ),
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
                              //show dialog on tap of this button
                              child: CircleAvatar(
                                backgroundColor:Colors.blue,
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  color: Colors.white,
                                  //using velocityX onTap here
                                ).onTap(() {
                                  //using getx dialog and passing our widget
                                  //passing context and our controller to the widget
                                  Get.dialog(pickerDialog(context, controller));
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      color: Colors.white,
                      height: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      title: TextFormField(
                        //setting controller
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
                            label: "Name".text.white.make(),
                            isDense: true,
                            labelStyle: const TextStyle(
                              //fontFamily: bold,
                              color: Colors.white,
                            )),
                      ),
                      subtitle: namesub.text.semiBold.gray400.make(),
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
                              // fontFamily: bold,
                              color: Colors.white,
                            )),
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
                              //fontFamily: bold,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                );
              } 
              else {
                //if data is not loaded yet show progress indication
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                );
              }
            }),
      ),
    );
  }
}

