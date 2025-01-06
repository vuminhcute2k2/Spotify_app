import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_spotify_app/app/modules/musicpage/controller/musicpage_controller.dart';
import 'package:music_spotify_app/app/modules/musicpage/view/musicpage_screen.dart';
import 'package:music_spotify_app/model/songJamgedo.dart';
import 'package:music_spotify_app/service/jamendo_service.dart';
import 'package:palette_generator/palette_generator.dart';

class AlbumListSongsScreen extends StatefulWidget {
  final String albumId;
  final String albumName;
  final String albumImageUrl;
  final String artistName;

  const AlbumListSongsScreen({
    Key? key,
    required this.albumId,
    required this.albumName,
    required this.albumImageUrl,
    required this.artistName,
  }) : super(key: key);

  @override
  _AlbumSongsScreenState createState() => _AlbumSongsScreenState();
}

class _AlbumSongsScreenState extends State<AlbumListSongsScreen> {
  final JamendoService _jamendoService = JamendoService();
  late Future<List<SongJamedo>> _songsFuture;
  Color? _dominantColor;

  @override
  void initState() {
    super.initState();
    _songsFuture = _jamendoService.fetchSongsByAlbumId(widget.albumId);
    _extractDominantColor();
  }

  Future<void> _extractDominantColor() async {
    try {
      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(
        NetworkImage(widget.albumImageUrl),
      );
      setState(() {
        _dominantColor = paletteGenerator.dominantColor?.color ?? Colors.white;
      });
    } catch (e) {
      setState(() {
        _dominantColor = Colors.white; // Đặt mặc định nếu gặp lỗi
      });
    }
  }

  //tính độ tương phản của màu
  Color getContrastColor(Color color) {
    final double luminance = color.computeLuminance();
    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final Color contrastColor = _dominantColor != null
        ? getContrastColor(_dominantColor!)
        : Colors.white;
    return Scaffold(
      body: Stack(
        children: [
          // Ảnh nền album
          Container(
            width: double.infinity,
            height: screenWidth * 0.6,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.albumImageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(38),
                bottomRight: Radius.circular(38),
              ),
            ),
          ),
          // Nút quay lại
          Positioned(
            top: 40,
            left: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
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
          // Tên album
          Positioned(
            top: 110,
            left: 30,
            right: 20,
            child: Text(
              widget.albumName,
              style: TextStyle(
                color: contrastColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Nút Follow
          Positioned(
            top: 160,
            left: 30,
            child: SizedBox(
              width: 100,
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  print('Follow album: ${widget.albumName}');
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: contrastColor, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Follow",
                  style: TextStyle(color: contrastColor),
                ),
              ),
            ),
          ),
          // Nút Play
          Positioned(
            top: 153,
            right: 60,
            width: 55,
            height: 55,
            child: GestureDetector(
              onTap: () {
                print('Play album: ${widget.albumName}');
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.play_arrow, color: Colors.black),
              ),
            ),
          ),
          // Nội dung chính
          SafeArea(
            child: Column(
              children: [
                SizedBox(
                    height: screenWidth * 0.6), // Để khoảng trống cho ảnh nền
                Expanded(
                  child: FutureBuilder<List<SongJamedo>>(
                    future: _songsFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Lỗi: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('Không có bài hát nào trong album này.'),
                        );
                      }

                      final songs = snapshot.data!;

                      return ListView.builder(
                        itemCount: songs.length,
                        itemBuilder: (context, index) {
                          final song = songs[index];
                          return ListTile(
                            leading: const Icon(
                              Icons.music_note,
                              color: Colors.white,
                            ),
                            title: Text(
                              song.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              song.artistName,
                              style: const TextStyle(color: Colors.grey),
                            ),
                            // Khi người dùng nhấn vào bài hát trong danh sách
                            onTap: () async {
                              print('Phát bài hát: ${song.name}');
                              final albumSongs = snapshot
                                  .data!; // Danh sách tất cả bài hát trong album

                              // Cập nhật danh sách bài hát album trong MusicPageController
                              final musicPageController =
                                  Get.find<MusicPageController>();

                              // Chuyển đổi List<SongJamedo> thành List<Map<String, dynamic>>
                              final albumSongsData = albumSongs.map((song) {
                                return {
                                  'imageUrl': song.cover.isNotEmpty
                                      ? song.cover
                                      : 'https://via.placeholder.com/150',
                                  'title': song.name,
                                  'artist': song.artistName,
                                  'musicSongs':
                                      song.url.isNotEmpty ? song.url : '',
                                };
                              }).toList();

                              // Kiểm tra xem albumSongsData có được thêm vào mảng hay không
                              print('Danh sách album đã được thêm vào mảng:');
                              print(albumSongsData);

                              musicPageController
                                  .updateAlbumPlaylist(albumSongsData);

                              // Cập nhật bài hát đã chọn trong MusicPageController
                              final songData = {
                                'imageUrl': song.cover.isNotEmpty
                                    ? song.cover
                                    : 'https://via.placeholder.com/150',
                                'title': song.name,
                                'artist': song.artistName,
                                'musicSongs':
                                    song.url.isNotEmpty ? song.url : '',
                              };
                              musicPageController.addSongToHistory(songData);
                              musicPageController.updateSelectedSong(songData);

                              // Chuyển sang MusicPageScreen
                              Get.to(() => MusicPageScreen(songData: songData));
                            },
                          );
                        },
                      );
                    },
                  ),
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
