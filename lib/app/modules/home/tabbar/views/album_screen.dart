import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/albums/views/albumListSongs_Screen.dart';
import 'package:music_spotify_app/app/modules/home/controller/home_controller.dart';

final HomeController homeController = Get.put(HomeController());
Widget ItemAlbum(BuildContext context) {
  
  return Obx(() {
    return ListView.builder(
      itemCount: homeController.albums.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        final album = homeController.albums[index];
        return GestureDetector(
          onTap: () async {
            final albumId = album['id']; // Lấy id của album
            await homeController.fetchAlbumTracks(albumId); // Gọi hàm fetch bài hát từ album
            Get.to(() => AlbumListSongsScreen(album: album)); // Điều hướng tới màn hình danh sách bài hát
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10, left: 2, top: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      album['images'][0]['url'],
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                  ),
                ),
                Text(
                  album['name'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  album['artists'][0]['name'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  });
}
