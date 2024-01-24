// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/musicpage/controller/musicpage_controller.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({super.key});

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  final MusicPageController favoriteController =
      Get.find<MusicPageController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            )),
        title: const Text(
          'Playlists',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: Obx(
        () {
          return ListView.builder(
            itemCount: favoriteController.songs.length,
            itemBuilder: (context, index) {
              final song = favoriteController.songs[index];
              return PlayListItem(song: song);
            },
          );
        },
      ),
    );
  }
}
class PlayListItem extends StatelessWidget {
  final Map<String, dynamic> song;

  PlayListItem({required this.song});
  final MusicPageController favoriteController = Get.put(MusicPageController());
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        song['nameSong'],
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        song['author'],
        style: const TextStyle(color: Colors.grey),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(song['image']),
      ),
      onTap: () {
        favoriteController.onSongSelected(song);
      },
    );
  }
}