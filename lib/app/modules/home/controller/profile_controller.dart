// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:path/path.dart';
// import 'dart:io' as io;
// import 'package:music_spotify_app/common/authentication.dart';

// class ProfileController extends GetxController {
//   var imgpath = ''.obs;
//   var imglink = "";
//   var nameController = TextEditingController();
//   var aboutController = TextEditingController();
//   var emailController = TextEditingController();
//   late SharedPreferences prefs;
//   static ProfileController instance = Get.find();
//   FirebaseAuth auth = FirebaseAuth.instance;
//   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//   User? currentUser = FirebaseAuth.instance.currentUser;
//   String username = '';
//   String userImage = '';
//   getUsersDetails() async {
//   await firebaseFirestore
//       .collection('users')
//       .where('uid', isEqualTo: currentUser!.uid)
//       .get()
//       .then((value) async {
//     if (value.docs.isNotEmpty) {
//       username = value.docs[0]['fullname'];
//       userImage = value.docs[0]['image'];
//       prefs = await SharedPreferences.getInstance();
//       prefs.setStringList('user_details', [
//         value.docs[0]['fullname'],
//         value.docs[0]['image'],
//       ]);

//       // Cập nhật giá trị imgpath từ SharedPreferences
//       imgpath.value = prefs.getString('user_details')![1] ?? '';
//     }
//   });
// }

//   Future<void> updateProfile(context) async {
//     //setting store variable to the document of our current user
//     var store = firebaseFirestore.collection('users').doc(currentUser!.uid);
//     //lets update data now
//     await store.set({
//       'name': nameController.text,
//       'about': aboutController.text,
//       //update the image_url field
//       //it will be empty if img is not selected
//       'image': imglink
//     }, SetOptions(merge: true));
//     await prefs.setString('user_image_path', imglink);
//     //show toats when done
//     VxToast.show(context, msg: "Profile updates successfully!");
//   }

//   pickImage(context, source) async {
//     //get premistion from user
//     await Permission.photos.request();
//     await Permission.camera.request();
//     //getting state of our permisson to handle
//     var status = await Permission.photos.status;
//     //handle status
//     if (status.isGranted) {
//       //when status is grandted
//       try {
//         //source will be accacrding to user choice
//         //picking image and saving in img variables
//         final img =
//             await ImagePicker().pickImage(source: source, imageQuality: 80);
//         //setting our variables equal to this image path
//         imgpath.value = img!.path;
//         //show toast after picking image
//         VxToast.show(context, msg: "Image selected");
//       } on PlatformException catch (e) {
//         VxToast.show(context, msg: e.toString());
//       }
//     } else {
//       //when status is not grandted
//       VxToast.show(context, msg: "Premisstion denied");
//     }
//   }
//   // lets upload the image to fire storage
//   // Future<String?> uploadImage()async{
//   //   //getting  name of the selected file
//   //   //
//   //   var name =basename(imgpath.value);
//   //   //setting destination of file on firestore
//   //   var destination ='imageUsers/${currentUser!.uid}/$name';
//   //   //trigering firestorage  to save of file
//   //   //adding the desination to create of file
//   //   Reference ref = FirebaseStorage.instance.ref().child(destination);
//   //   //uploading our file
//   //   io.File file = io.File(imgpath.value);  // Sử dụng tên bí danh 'io' để truy cập lớp 'File'
//   //   await ref.putFile(file);
//   //   //getting url of our upload file and saving it into our  linking variable
//   //   if(ref != null){
//   //     var d = await ref.getDownloadURL();
//   //     print(d);
//   //     imglink = d;
//   //   }
//   //   return null;
//   // }

//   Future<String?> uploadImage() async {
//     // Kiểm tra xem imgpath có giá trị không rỗng
//     if (imgpath.value.isNotEmpty) {
//       var name = basename(imgpath.value);

//       // Kiểm tra xem file có tồn tại không
//       io.File file = io.File(imgpath.value);
//       if (file.existsSync()) {
//         // Đường dẫn hợp lệ, tiếp tục quá trình tải lên

//         // Định dạng đường dẫn trên Firebase Storage
//         var destination = 'imageUsers/${currentUser!.uid}/$name';

//         // Tạo tham chiếu đến Firebase Storage
//         Reference ref = FirebaseStorage.instance.ref().child(destination);

//         try {
//           // Tải lên file
//           await ref.putFile(file);

//           // Lấy đường dẫn URL của file đã tải lên
//           var downloadURL = await ref.getDownloadURL();

//           // Gán URL vào biến imglink
//           imglink = downloadURL;
//           print(imglink);

//           // Trả về null nếu quá trình tải lên thành công
//           return null;
//         } catch (e) {
//           // Xử lý lỗi nếu có
//           print('Lỗi khi tải lên file: $e');
//           return 'Lỗi khi tải lên file';
//         }
//       } else {
//         // File không tồn tại, in thông báo lỗi và trả về
//         print('File không tồn tại.');
//         return 'File không tồn tại';
//       }
//     } else {
//       // Đường dẫn file không hợp lệ, in thông báo lỗi và trả về
//       print('Đường dẫn file không hợp lệ.');
//       return 'Đường dẫn file không hợp lệ';
//     }
//   }

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     getUsersDetails();
//     imgpath.value = '';
//     super.onInit();
//   }
// }

import 'dart:io' as io;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:music_spotify_app/model/user.dart';
import 'package:music_spotify_app/service/store_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileController extends GetxController {
  var nameController = TextEditingController();
  var aboutController = TextEditingController();
  var emailController = TextEditingController();
  //variables for image
  var imgpath = ''.obs;
  var imglink = '';
  var shouldReload = false.obs;
  static ProfileController get instance => Get.find<ProfileController>();
  Rx<User?> userData = Rx<User?>(null);
  @override
  void onInit() {
    super.onInit();
    ever<User?>(userData, (newUserData) {
      //cập nhật giao diện người dùng khi có sự thay đổi trong dữ liệu người dùng
      if (newUserData != null) {
        nameController.text = newUserData.fullname;
      }
    });
  }
  void reloadPage() {
    shouldReload.toggle();
  }
  loadUserData() async {
   ProfileController profileController = Get.find();
    // Gọi hàm lấy dữ liệu từ Firebase hoặc nơi bạn lưu trữ dữ liệu người dùng
    User? newUser = await fetchDataFromFirebase();
    // Cập nhật dữ liệu người dùng trong GetX controller
    userData(newUser);
    // Gọi update() để thông báo cho GetX rằng dữ liệu đã thay đổi và cần cập nhật giao diện
    update();
  }

  Future<User?> fetchDataFromFirebase() async {
    try {
      print(1);
      var userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .get();
      print(2);

      if (userDoc.exists) {
        // Chuyển đổi dữ liệu từ Firestore thành đối tượng UserData
        User userData = User(
          email: userDoc['email'],
          about: userDoc['about'],
          uid: userDoc['uid'],
          image: userDoc['image'],
          fullname: userDoc['fullname'],
          password: userDoc['password'],
          followers: List.from(userDoc['followers']),
          following: List.from(userDoc['following']),
        );
        print(userData);
        return userData;
      } else {
        // Nếu tài khoản không tồn tại, trả về null 
        return null;
      }
    } catch (e) {
      // Xử lý lỗi khi truy vấn dữ liệu từ Firebase
      print('Error fetching data from Firebase: $e');
      return null;
    }
  }

  //update profile method
  updateProfile(context) async {
    var store = FirebaseFirestore.instance.collection('users').doc(currentUser!.uid);
    await store.set({
      'fullname': nameController.text,
      'about': aboutController.text,
      'image': imglink
    }, SetOptions(merge: true));
   
    VxToast.show(context, msg: "Profile updates successfully!");
  }

  //image picking method
  pickImage(context, source) async {
    await Permission.photos.request();
    await Permission.camera.request();
    var status = await Permission.photos.status;
    var camera = await Permission.camera.status;
    //handle status
    if (status.isGranted || camera.isGranted) {
      try {
        final img =
            await ImagePicker().pickImage(source: source, imageQuality: 80);
        imgpath.value = img!.path;
        VxToast.show(context, msg: "Image selected");
      } on PlatformException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
    } else {
      VxToast.show(context, msg: "Premisstion denied");
    }
  }

  //uploadImage
  uploadImage() async {
    var name = basename(imgpath.value);
    //Thiết lập đường dẫn đích của tệp trên Firestore
    var destination = 'images/${currentUser!.uid}/$name';
    //Thêm đường dẫn đích để tạo tệp
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    io.File file = io.File(
        imgpath.value); // Sử dụng tên bí danh 'io' để truy cập lớp 'File'
    await ref.putFile(file);
    // Lấy URL của tệp tải lên và lưu 
    var d = await ref.getDownloadURL();
    print(d);
    imglink = d;
  }
}
