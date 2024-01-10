import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_spotify_app/app/modules/musicpage/view/musicpage_screen.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:velocity_x/velocity_x.dart';

class MusicPageController extends GetxController {
  final RxList<Map<String, dynamic>> _songs = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> get songs => _songs;
  late AudioPlayer audioPlayer;
  final _playlist = ConcatenatingAudioSource(children: [
    // Add your AudioSource objects to the playlist here
  ]);
  //map chứa dữ liệu của songs
  late final Rx<Map<String, dynamic>> selectedSong = Rx<Map<String, dynamic>>({});
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
    if (songs.isNotEmpty) {
    updateSelectedSong(songs.first);
  }else{
    print('không nhận đc giá trị');
  }
  replayCurrentSong();
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
  // Đoạn mã để cập nhật selectedSong khi chọn một bài hát mới
// void selectSong(Map<String, dynamic> song) {
//   updateSelectedSong(song);
//   // Các xử lý khác khi chọn một bài hát mới
// }

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
    print(qn.docs);
    final List<AudioSource> songs = qn.docs.map((doc) {
      return AudioSource.uri(
        Uri.parse(doc["song"]),
        tag: MediaItem(
          id: doc["song"],
          title: doc["nameSong"],
          artist: doc["author"],
          artUri: Uri.parse(doc["image"]),
        ),
      );
    }).toList();
    //  print("SỐ ${songs.elementAt(1).} audio sources.");
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
     
    // add mp3 vào newplaylist để chạy nhạc 
    final newPlaylist = ConcatenatingAudioSource(children: songs);
    print('Playlist ${newPlaylist}');
    // Set the new playlist to the audioPlayer
    await audioPlayer.setAudioSource(newPlaylist);
    // Nếu có bài hát, cập nhật selectedSong với bài hát đầu tiên
   

  } catch (e) {
    print("Error fetching Songs: $e");
  }
}

}




