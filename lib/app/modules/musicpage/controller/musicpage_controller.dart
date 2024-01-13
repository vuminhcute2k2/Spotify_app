import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_spotify_app/app/modules/musicpage/view/musicpage_screen.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:velocity_x/velocity_x.dart';

class MusicPageController extends GetxController {
  //Function(Map<String, dynamic>)? playSelectedSongCallback;

  final RxList<Map<String, dynamic>> _songs = <Map<String, dynamic>>[].obs;
  List<Map<String, dynamic>> get songs => _songs;
  late AudioPlayer audioPlayer;
  final _playlist = ConcatenatingAudioSource(children: []);
  //map chứa dữ liệu của songs
  late final Rx<Map<String, dynamic>> selectedSong =
      Rx<Map<String, dynamic>>({});
//khởi tạo một stream để thông báo khi 1 bài nhạc được thay đổi 
  final _songChangedController = StreamController<void>.broadcast();
  Stream<void> get onSongChanged => _songChangedController.stream;
  RxMap currentSong = {}.obs;
  //biểu thị thời gian hiện tại của âm thanh
  Stream<Duration> get positionStream => audioPlayer.positionStream;
  //biểu thị thời gian đệm (đoạn load mờ hơn phía sau)
  Stream<Duration> get bufferedPositionStream =>
      audioPlayer.bufferedPositionStream;
  //biểu thị thời gian tổng
  Stream<Duration?> get durationStream => audioPlayer.durationStream;
  //biểu thị trạng thái của trình phát liên tục
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
  }


  void updateSelectedSong(Map<String, dynamic> song) async {
    currentSong.value = RxMap<String, dynamic>.from(song);
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await _firestore.collection("today-songs").get();
    // for (QueryDocumentSnapshot doc in qn.docs) {
    //   print("Document ID: ${doc.id}");
    //   print("NameSong: ${doc["nameSong"]}");
    //   print("Author: ${doc["author"]}");
    //   print("Song URL: ${doc["song"]}");
    //   print("Image URL: ${doc["image"]}");
    //   print("----------------------------------------");
    // }
    _songChangedController.add(null);
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
   
    //biến giám sát index
    int indexOfSelectedSong = songs.indexWhere((source) {
      // Kiểm tra xem source có phải là UriAudioSource không
      if (source is UriAudioSource) {
        // Kiểm tra xem giá trị song của bài hát có khớp với Uri không
        return Uri.parse(song['song']) == source.uri;
      }
      return false;
    });
    final newPlaylist = ConcatenatingAudioSource(
      children: songs,
    );
    await audioPlayer.setAudioSource(newPlaylist,
        initialIndex: indexOfSelectedSong, initialPosition: Duration.zero);
    // await audioPlayer.seek(Duration.zero, index: );
  }

  // Đoạn mã để cập nhật selectedSong khi chọn một bài hát mới
  void onSongSelected(Map<String, dynamic> song) {
    // Cập nhật thông tin và chơi bài hát ở đây
    updateSelectedSong(song);
    Get.to(() => MusicPageScreen(songData: song));
    replayCurrentSong();
  }

  Future<void> _init() async {
    try {
      await audioPlayer.setLoopMode(LoopMode.all);
      await audioPlayer.setAudioSource(_playlist);
    } catch (e) {
      print('Error initializing audio player: $e');
    }
  }
//hàm replay
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
      print("SỐ ${songs.length} audio sources.");
     
    } catch (e) {
      print("Error fetching Songs: $e");
    }
  }
}

