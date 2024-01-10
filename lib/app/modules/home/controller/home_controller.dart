import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/musicpage/view/musicpage_screen.dart';
import 'package:music_spotify_app/app/modules/musicpage/controller/musicpage_controller.dart';
class HomeController extends GetxController {
  var carouselImages = <String>[].obs;
  var dotPosition = 0.obs;

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
            "id":doc["id"],
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

  
