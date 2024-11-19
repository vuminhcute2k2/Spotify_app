import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/musicpage/view/musicpage_screen.dart';
import 'package:music_spotify_app/app/modules/musicpage/controller/musicpage_controller.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  var carouselImages = <String>[].obs;
  var dotPosition = 0.obs;
  RxList<dynamic> albums = [].obs;

  final RxList<Map<String, dynamic>> _songs = <Map<String, dynamic>>[].obs;

  List<Map<String, dynamic>> get songs => _songs;
  @override
  void onInit() {
    fetchCarouselImages(); // Gọi phương thức này khi controller được khởi tạo
    fetchSongs();
    super.onInit();
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

  Future<void> fetchAlbums() async {
    const clientId = 'ff6dfa31695249239b64551801a0d7a6';
    const clientSecret = 'ec2461c95b2644ae8df27180db9876ad';
    final token = await _getAccessToken(clientId, clientSecret);

    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/browse/new-releases'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      albums.value = data['albums']['items'];
    } else {
      print('Failed to fetch albums: ${response.statusCode}');
    }
  }

  Future<String> _getAccessToken(String clientId, String clientSecret) async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['access_token'];
    } else {
      throw Exception('Failed to get access token');
    }
  }

  Future<void> fetchAlbumTracks(String albumId) async {
    try {
      const clientId = 'ff6dfa31695249239b64551801a0d7a6';
      const clientSecret = 'ec2461c95b2644ae8df27180db9876ad';
      final token = await _getAccessToken(clientId, clientSecret);

      final response = await http.get(
        Uri.parse('https://api.spotify.com/v1/albums/$albumId/tracks'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Lấy URL ảnh của album
        final albumResponse = await http.get(
          Uri.parse('https://api.spotify.com/v1/albums/$albumId'),
          headers: {'Authorization': 'Bearer $token'},
        );

        final albumData = json.decode(albumResponse.body);
        final albumImage = albumData['images'][0]['url']; // Lấy ảnh album

        _songs.assignAll((data['items'] as List)
            .map((item) => {
                  'name': item['name'],
                  'artists': (item['artists'] as List)
                      .map((artist) => artist['name'])
                      .join(', '),
                  'uri': item['uri'],
                  'trackNumber': item['track_number'],
                  'image': albumImage, // Sử dụng ảnh album cho từng bài hát
                })
            .toList());
      } else {
        print('Failed to fetch album tracks: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching album tracks: $e');
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
