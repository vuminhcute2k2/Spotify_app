import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_spotify_app/app/modules/musicpage/view/musicpage_screen.dart';
import 'package:rxdart/rxdart.dart' as rx;

class MusicPageController extends GetxController {
  final RxList<Map<String, dynamic>> _songs = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> get songs => _songs;
  late AudioPlayer audioPlayer;
  final _playlist = ConcatenatingAudioSource(children: [
    // Add your AudioSource objects to the playlist here
  ]);
  //map chứa dữ liệu của songs
  late final Rx<Map<String, dynamic>> selectedSong =
      Rx<Map<String, dynamic>>({});

  Stream<Duration> get positionStream => audioPlayer.positionStream;
  Stream<Duration> get bufferedPositionStream =>
      audioPlayer.bufferedPositionStream;
  Stream<Duration?> get durationStream => audioPlayer.durationStream;

  Stream<SequenceState?> get sequenceStateStream =>
      audioPlayer.sequenceStateStream;
  Stream<PositionData> get positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          audioPlayer.positionStream,
          audioPlayer.bufferedPositionStream,
          audioPlayer.durationStream,
          (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
    _init();
    musicSongs();
    replayCurrentSong();
    //updateSelectedSong();
  }

  // Hàm để cập nhật bài hát được chọn
  void updateSelectedSong(Map<String, dynamic> song) {
    selectedSong.update((val) {
      val!['image'] = song['image'];
      val['nameSong'] = song['nameSong'];
      val['author'] = song['author'];
      val['song'] = song['song'];
    });
  }

  Future<void> _init() async {
    try {
      await audioPlayer.setLoopMode(LoopMode.all);
      await audioPlayer.setAudioSource(_playlist);
    } catch (e) {
      print('Error initializing audio player: $e');
    }
  }

  // Handle replay current song event
  void replayCurrentSong() async {
    await audioPlayer.stop();
    await audioPlayer.seek(Duration.zero);
    await audioPlayer.play();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }

  
Future<void> musicSongs() async {
  try {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestore.collection("today-songs").get();

    final List<AudioSource> songs = qn.docs.map((doc) {
      return AudioSource.uri(
        Uri.parse(doc["song"]),
        tag: MediaItem(
          id: doc["id"],
          title: doc["nameSong"],
          artist: doc["author"],
          artUri: Uri.parse(doc["image"]),
        ),
      );
    }).toList();

    // Create a new ConcatenatingAudioSource with the new list of songs
    final newPlaylist = ConcatenatingAudioSource(children: songs);
    
    // Set the new playlist to the audioPlayer
    await audioPlayer.setAudioSource(newPlaylist);

  } catch (e) {
    print("Error fetching Songs: $e");
  }
}
//   Future<void> musicSongs() async {
//   try {
//     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//     QuerySnapshot qn = await _firestore.collection("today-songs").get();

//     final List<AudioSource> songs = qn.docs.map((doc) {
//       return AudioSource.uri(
//         Uri.parse(doc["song"]),
//         tag: MediaItem(
//           id: doc["id"],
//           title: doc["nameSong"],
//           artist: doc["author"],
//           artUri: Uri.parse(doc["image"]),
//         ),
//       );
//     }).toList();

//     _playlist.add(songs as AudioSource);
//   } catch (e) {
//     print("Error fetching Songs: $e");
//   }
// }
}




//   final Rx<AudioPlayer> _audioPlayer = AudioPlayer().obs;
//   final Rx<ConcatenatingAudioSource> _playlist =
//       ConcatenatingAudioSource(children: []).obs;

//   AudioPlayer get audioPlayer => _audioPlayer.value;
//   ConcatenatingAudioSource get playlist => _playlist.value;

//   @override
//   void onInit() {
//     // Khởi tạo controller
//     _init();
//     // Lấy danh sách bài hát từ Firestore
//     _fetchSongsFromFirestore();
//     super.onInit();
//   }

//   Future<void> _init() async {
//     try {
//       await audioPlayer.setLoopMode(LoopMode.all);
//       await audioPlayer.setAudioSource(playlist);
//     } catch (e) {
//       print('Error initializing audio player: $e');
//     }
//   }

//   Future<void> _fetchSongsFromFirestore() async {
//     try {
//     final QuerySnapshot<Map<String, dynamic>> snapshot =
//         await FirebaseFirestore.instance.collection("today-songs").get();
//     final songs = snapshot.docs.map((doc) {
//       final data = doc.data();
//       return AudioSource.uri(
//         Uri.parse(data["song"]),
//         tag: MediaItem(
//           id: data["id"],
//           title: data["nameSong"],
//           artist: data["author"],
//           artUri: Uri.parse(data["image"]),
//         ),
//       );
//     }).toList();
//     // Xóa danh sách phát hiện tại và thêm danh sách mới
//     _playlist.value = ConcatenatingAudioSource(children: songs);
//   } catch (e) {
//     print("Error fetching songs from Firestore: $e");
//   }
//   }

//   // Thêm bài hát vào danh sách phát
//  void addSongToPlaylist(MediaItem mediaItem) {
//   playlist.add(
//     AudioSource.uri(
//       Uri.parse(mediaItem.id!),
//       tag: mediaItem,
//       uri: Uri.parse(mediaItem.artUri.toString()),
//     ),
//   );
// }

//   // Xóa toàn bộ danh sách phát
//   void clearPlaylist() {
//     playlist.clear();
//   }

//   // Xử lý sự kiện replay
//   Future<void> replayCurrentSong() async {
//     await audioPlayer.stop();
//     await audioPlayer.seek(Duration.zero);
//     await audioPlayer.play();
//   }
