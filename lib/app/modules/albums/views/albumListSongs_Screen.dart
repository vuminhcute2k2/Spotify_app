import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/home/controller/home_controller.dart';
import 'package:music_spotify_app/app/modules/musicpage/controller/musicpage_controller.dart';
import 'package:music_spotify_app/generated/image_constants.dart';

class AlbumListSongsScreen extends StatelessWidget {
  final Map<String, dynamic> album;

  AlbumListSongsScreen({required this.album});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final HomeController homeController = Get.find<HomeController>();
    final MusicPageController musicPageController = Get.find<MusicPageController>();
    // Lấy các bài hát của album sau khi nhận được thông tin album
    homeController.fetchAlbumTracks(album['id']);

    return Scaffold(
      body: Stack(
        children: [
          // Background Container
          Container(
            width: double.infinity,
            height: screenWidth * 0.6,
            decoration: BoxDecoration(
              image: album['images'][2]['url'] != null
                  ? DecorationImage(
                      image: NetworkImage(album['images'][2]['url']),
                      fit: BoxFit.cover,
                    )
                  : null,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
          ),
          Positioned(
            top: 110,
            left: 30,
            right: 20,
            child: Text(
              album['name'],
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Positioned(
            top: 160,
            left: 30,
            child: SizedBox(
              width: 100,
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  // Xử lý khi nhấn nút
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                      color: Colors.white, width: 1), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), 
                  ),
                ),
                child: const Text(
                  "Follow",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Positioned(
            top: 153,
            right: 60,
            width: 55,
            height: 55,
            child: InkWell(
              onTap: () {
                print("Play button tapped");
              },
              child: SvgPicture.asset(
                ImageConstant.imgIcPlayTopHits,
              ),
            ),
          ),

          // SafeArea Content
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: screenWidth * 0.6), 
                Expanded(
                  child: Obx(() {
                    final tracks = homeController.songs;

                    return ListView.builder(
                      itemCount: tracks.length,
                      itemBuilder: (context, index) {
                        final track = tracks[index];
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              track['image'],
                              fit: BoxFit.cover,
                              width: 50,
                              height: 50,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image,
                                    color: Colors.white);
                              },
                            ),
                          ),
                          title: Text(
                            track['name'],
                            style: const TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            track['artists'],
                            style: const TextStyle(color: Colors.grey),
                          ),
                          onTap: () {
                            MusicPageController musicPageController = Get.put(MusicPageController());
                            print(track);
                            musicPageController.onSongSelected(track);
                            print("ấn ấn ấn");
                          },
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
