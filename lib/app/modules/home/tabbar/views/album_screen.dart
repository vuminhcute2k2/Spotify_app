import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/album/views/listAlbum_song.dart';
import 'package:music_spotify_app/app/modules/home/controller/home_controller.dart';

final HomeController homeController = Get.put(HomeController());

Widget ItemAlbum(BuildContext context) {
  return Obx(() {
    // Kiểm tra nếu albums list trống
    if (homeController.albums.isEmpty) {
      return const Center(
        child: CircularProgressIndicator(), 
      );
    }

    return ListView.builder(
      itemCount: homeController.albums.length, // Số lượng album trong danh sách
      scrollDirection: Axis.horizontal, // Cuộn ngang
      itemBuilder: (context, index) {
        final album = homeController.albums[index]; // Lấy album tại vị trí index

        return GestureDetector(
          onTap: () async {
            Get.to(() => AlbumListSongsScreen(
                    albumId: album.id, // Truyền ID của album
                    albumName: album.name, // Truyền tên album
                    albumImageUrl: album.image,
                    artistName: album.artistName,
                  ));
          },
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.3, // Chiều rộng album
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10, left: 2, top: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16), 
                    child: Image.network(
                      album.image, 
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width * 0.25, // Chiều rộng ảnh
                      height: MediaQuery.of(context).size.height * 0.12, // Chiều cao ảnh
                    ),
                  ),
                ),
                SizedBox(height: 8), // Khoảng cách giữa ảnh và tên album
                Text(
                  album.name, // Hiển thị tên album
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  album.artistName, // Hiển thị tên nghệ sĩ
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