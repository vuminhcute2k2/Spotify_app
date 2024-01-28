import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/musicpage/controller/musicpage_controller.dart';

class PlayListScreen extends StatefulWidget {
  const PlayListScreen({Key? key}) : super(key: key);

  @override
  State<PlayListScreen> createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  final MusicPageController favoriteController =
      Get.find<MusicPageController>();

  Widget playListItem(Map<String, dynamic> song) {
    return ListTile(
      title: Text(
        song['title'],
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        song['artist'],
        style: const TextStyle(color: Colors.grey),
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(song['imageUrl']),
      ),
      onTap: () {
        favoriteController.playFavoriteSongs(selectedSong: song);
      },
    );
  }

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
          ),
        ),
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
            ),
          ),
        ],
      ),
      body: GetBuilder<MusicPageController>(
        builder: (controller) {
          return FutureBuilder<List<Map<String, dynamic>>>(
            future: favoriteController.getFavoriteSongsDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No favorite songs.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                final favoriteSongs = snapshot.data!;
                return ListView.builder(
                  itemCount: favoriteSongs.length,
                  itemBuilder: (context, index) {
                    final song = favoriteSongs[index];
                    return playListItem(song);
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
