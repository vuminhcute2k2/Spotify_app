import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:music_spotify_app/model/albums.dart';
import 'package:music_spotify_app/service/jamendo_service.dart';

class HomeController extends GetxController {
  var carouselImages = <String>[].obs;
  var dotPosition = 0.obs;

  final RxList<Map<String, dynamic>> _songs = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get songs => _songs;
  // var albums = <Map<String, dynamic>>[].obs;
  // final String clientId = '20cdc097';
  //hiển thị danh sách album
  var albums = <Album>[].obs;
  final JamendoService _jamendoService = JamendoService();

  //khai báo list moodAlbums
  var moodAlbums = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    fetchCarouselImages(); // Gọi phương thức này khi controller được khởi tạo
    fetchSongs();
    fetchAlbums();
    super.onInit();
  }

  // Phương thức để cập nhật danh sách album
  void updateMoodAlbums(List<dynamic> albumData) {
    moodAlbums.clear();
    moodAlbums.addAll(
      albumData.map((item) => item as Map<String, dynamic>).toList(),
    );
  }



  // Future<void> fetchAlbums() async {
  //   try {
  //     final response = await http.get(
  //       Uri.parse('https://api.jamendo.com/v3.0/albums/?client_id=$clientId&limit=10&format=json'),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = json.decode(response.body);
  //       // Lưu dữ liệu album vào biến
  //       albums.assignAll((data['albums'] as List)
  //           .map((album) => {
  //                 'id': album['id'],
  //                 'name': album['name'],
  //                 'image': album['image'],
  //                 'artist': album['artist']['name'],
  //               })
  //           .toList());
  //     } else {
  //       print('Failed to fetch albums: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching albums: $e');
  //   }
  // }
  Future<void> fetchAlbums() async {
    try {
      List<Album> fetchedAlbums = await _jamendoService.fetchAlbums();
      albums.value = fetchedAlbums; // Cập nhật danh sách album
    } catch (e) {
      print("Error fetching albums: $e");
    }
  }

  Future<void> fetchCarouselImages() async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      QuerySnapshot qn = await _firestore.collection("carousel-slider").get();
      carouselImages.clear();
      carouselImages.addAll(
        qn.docs.map(
          (doc) => doc["imageCarousel"] as String,
        ),
      );
    } catch (e) {
      print("Error fetching carousel images: $e");
    }
  }

  void changeDotPosition(int newPosition) {
    dotPosition.value = newPosition;
  }

  Future<void> fetchSongs() async {
    try {
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      QuerySnapshot qn = await _firestore.collection("today-songs").get();
      _songs.assignAll(
        qn.docs.map(
          (doc) => {
            "nameSong": doc["nameSong"],
            "song": doc["song"],
            "id": doc["id"],
            "image": doc["image"],
            "author": doc["author"],
          },
        ),
      );
    } catch (e) {
      // Xử lý lỗi nếu cần
      print("Error fetching Songs: $e");
    }

    // _songs.refresh();
  }

  // Thêm hàm để lấy dữ liệu chi tiết của một bài hát từ Firebase
  // Future<Map<String, dynamic>> getSongDetails(String songId) async {
  //   try {
  //     DocumentSnapshot songSnapshot = await FirebaseFirestore.instance
  //         .collection("today-hits")
  //         .doc(songId)
  //         .get();

  //     if (songSnapshot.exists) {
  //       return songSnapshot.data() as Map<String, dynamic>;
  //     } else {
  //       // Xử lý trường hợp bài hát không tồn tại
  //       return {};
  //     }
  //   } catch (e) {
  //     print("Error fetching song details: $e");
  //     return {};
  //   }
  // }
}
