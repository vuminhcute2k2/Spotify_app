// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/album/views/listAlbum_song.dart';
import 'package:music_spotify_app/app/modules/home/tabbar/views/album_screen.dart';
import 'package:http/http.dart' as http;
import 'package:music_spotify_app/app/modules/musicpage/controller/musicpage_controller.dart';
import 'package:music_spotify_app/app/modules/musicpage/view/musicpage_screen.dart';
import 'package:music_spotify_app/app/modules/searchbar/views/search_screen.dart';
import 'package:music_spotify_app/app/routes/app_routes.dart';
import 'package:music_spotify_app/generated/image_constants.dart';
import 'package:music_spotify_app/app/modules/home/tabbar/views/artist_screen.dart';
import 'package:music_spotify_app/app/modules/home/controller/home_controller.dart';
import 'package:music_spotify_app/model/songs.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen>
    with TickerProviderStateMixin {
  final HomeController homeController = Get.put(HomeController());

  final MusicPageController musicController = Get.put(MusicPageController());
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 4, vsync: this);
    homeController.fetchCarouselImages();
    homeController.fetchSongs();
    // Gọi hàm hiển thị popup khi trang được tạo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showMoodDialog(context);
    });
  }

  // Hàm để hiển thị popup cho người dùng nhập tâm trạng
  void _showMoodDialog(BuildContext context) {
    TextEditingController moodController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Enter your mood"),
          content: TextField(
            controller: moodController,
            decoration: InputDecoration(hintText: "Enter your mood here"),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _analyzeMood(
                    moodController.text); // Phân tích tâm trạng người dùng
              },
              child: Text("Analyze"),
            ),
          ],
        );
      },
    );
  }

  // Hàm phân tích tâm trạng và gửi dữ liệu tới API
  void _analyzeMood(String moodText) async {
    try {
      // In ra body yêu cầu để kiểm tra định dạng
      print('Request Body: ${jsonEncode({'text': moodText})}');
      print('Request Headers: { "Content-Type": "application/json" }');

      var response = await http.post(
        Uri.parse(
            "https://d270-27-79-153-197.ngrok-free.app/recommend_albums"),
        headers: {
          'Content-Type': 'application/json', // Đảm bảo đúng Content-Type
        },
        body:
            jsonEncode({'mood': moodText}), // Đảm bảo body đúng định dạng JSON
      );

      // Kiểm tra nếu status code của response là 200 (thành công)
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        final List<dynamic>? recommendedAlbums = data['recommended_albums'];

        // Gọi controller để cập nhật danh sách album theo tâm trạng
        if (recommendedAlbums != null && recommendedAlbums.isNotEmpty) {
          homeController.moodAlbums.clear();
          final List<dynamic>? recommendedAlbums = data['recommended_albums'];
          homeController.moodAlbums.assignAll(recommendedAlbums
                  ?.map((album) => Map<String, dynamic>.from(album)) ??
              []);
          print('No albums found.');
        } else {
          // Xử lý nếu danh sách tồn tại
          for (var album in recommendedAlbums!) {
            print("danh sách album mood : $album");
          }
        }
      } else {
        _showError("Failed to process mood: ${response.body}");
      }
    } catch (e) {
      _showError("Error: $e");
    }
  }

// Hàm hiển thị lỗi bằng snackbar
  void _showError(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
    print("error : $message");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => SearchScreen(),
                            transition: Transition.downToUp);
                      },
                      child: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    Container(
                      child: Center(
                        child: Image.asset(
                          'assets/images/logo_feelTunes_removebg.png',
                          width: 133,
                          height: 40,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Stack(
                    children: [
                      Obx(
                        () => Container(
                          width: double.infinity,
                          height: double.infinity,
                          child: CarouselSlider(
                            items: homeController.carouselImages
                                .map(
                                  (item) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(item),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 0.8,
                              enlargeStrategy: CenterPageEnlargeStrategy.height,
                              onPageChanged: (val, _) {
                                homeController.changeDotPosition(val);
                              },
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.05,
                        left: MediaQuery.of(context).size.width * 0.1,
                        child: InkWell(
                          onTap: () {
                            //scrollCarousel(true);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: SvgPicture.asset(
                              ImageConstant.imgVectorOnprimarycontainer,
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.05,
                        right: MediaQuery.of(context).size.width * 0.1,
                        child: InkWell(
                          onTap: () {
                            //scrollCarousel(false);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(80),
                            ),
                            child: SvgPicture.asset(
                              ImageConstant.imgVector,
                              width: 26,
                              height: 26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Today’s hits",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.065,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: ListView.builder(
                    itemCount: homeController.songs.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final todayHit = homeController.songs[index];
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10, left: 2),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      musicController.onSongSelected(todayHit);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.15,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.network(
                                          todayHit['image'],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    right: 10,
                                    child: SvgPicture.asset(
                                        ImageConstant.imgIcPlayTopHits),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              todayHit['nameSong'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              todayHit['author'],
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Mood Albums for U",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.065,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.22,
                  child: Obx(
                    () => ListView.builder(
                      itemCount: homeController.moodAlbums.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        final album = homeController.moodAlbums[index];
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(right: 10, left: 2),
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        // Thực hiện các hành động khi người dùng chọn album
                                        Get.to(
                                          () => AlbumListSongsScreen(
                                            albumId: album[
                                                'id'], // Truyền ID của album
                                            albumName: album[
                                                'name'], // Truyền tên của album
                                            albumImageUrl: album[
                                                'image'], // Truyền URL ảnh của album
                                            artistName: album[
                                                'artist_name'], // Truyền tên nghệ sĩ
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.network(
                                            album[
                                                'image'], // Hiển thị hình ảnh từ URL album
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                album['name'], // Hiển thị tên album
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                album['artist_name'], // Hiển thị tên nghệ sĩ
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: TabBar(
                    controller: tabviewController,
                    labelColor: const Color(0XFFF42C83C),
                    tabs: [
                      Tab(
                        child: Container(
                          child: const Text(
                            'Artists',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Text(
                            'Album',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Text(
                            'Podcast',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Tab(
                        child: Container(
                          child: const Text(
                            'Genre',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                    indicator: const UnderlineTabIndicator(
                      borderSide: BorderSide(
                        width: 0.0,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: TabBarView(
                    controller: tabviewController,
                    children: [
                      ItemArtist(context),
                      // const Center(
                      //   child: Text(
                      //     "It's Album",
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      ItemAlbum(context),
                      const Center(
                        child: Text(
                          "It's Podcast",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const Center(
                        child: Text(
                          "It's Genre",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListMusicHits {
  String imageTopHits;
  String nameSongs;
  String author;
  ListMusicHits({
    required this.imageTopHits,
    required this.nameSongs,
    required this.author,
  });
}
