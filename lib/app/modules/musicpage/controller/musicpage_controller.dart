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
  late final Rx<Map<String, dynamic>> selectedSong = Rx<Map<String, dynamic>>({});
  RxMap currentSong = {}.obs;
  //biến theo dõi bài hát
  int currentSongIndex = 0;

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
    //replayCurrentSong();
  }

  //Hàm để cập nhật bài hát được chọn
  // void updateSelectedSong(Map<String, dynamic> song) async {
  //   // Cập nhật selectedSong với thông tin mới
  //   currentSong.value = RxMap<String, dynamic>.from(song);
  //   //selectedSong.value = song;
  //   // Dừng phát nhạc trước khi cập nhật bài hát mới
  //   //await audioPlayer.stop();
  //   // Tạo một AudioSource mới với thông tin của bài hát được chọn
  //   AudioSource audioSource = AudioSource.uri(
  //     Uri.parse(song['song']),
  //     tag: MediaItem(
  //       id: song['song'],
  //       title: song['nameSong'],
  //       artist: song['author'],
  //       artUri: Uri.parse(song['image']),
  //       extras: {'image': song['image']},
  //     ),
  //   );
  //   audioPlayer.play();
  //   // Xóa tất cả các AudioSource hiện tại và thêm AudioSource mới
  //   audioPlayer.setAudioSource(ConcatenatingAudioSource(children: [audioSource]));
  //   // Cập nhật thông tin như hình ảnh, tên bài hát, tác giả, ...
  //   // Điều này phụ thuộc vào cách bạn hiển thị thông tin nhạc trong ứng dụng của bạn
  //   print('Updating selectedSong with: $song');
  // }
  void updateSelectedSong(List<Map<String, dynamic>> songs, int index) async {
  try {
    // Dừng phát nhạc trước khi chuyển đến bài hát mới
    await audioPlayer.stop();

    // Cập nhật chỉ số và bài hát đang chơi
    currentSongIndex = index;
    Map<String, dynamic> song = songs[index];

    // Tạo một AudioSource mới với thông tin của bài hát được chọn
    AudioSource audioSource = AudioSource.uri(
      Uri.parse(song['song']),
      tag: MediaItem(
        id: song['song'],
        album: '',
        title: song['nameSong'],
        artist: song['author'],
        artUri: Uri.parse(song['image']),
        extras: {'image': song['image']},
      ),
    );

    // Xóa tất cả các AudioSource hiện tại và thêm AudioSource mới
    audioPlayer.setAudioSource(ConcatenatingAudioSource(children: [audioSource]));
    
    // Chơi bài hát mới
    audioPlayer.play();

    // Cập nhật thông tin như hình ảnh, tên bài hát, tác giả, ...
    selectedSong.value = song;
    print('Updating selectedSong with: $song');
  } catch (e) {
    print('Error updating selectedSong: $e');
  }
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

      // Log thông tin của từng document trong collection
      // for (QueryDocumentSnapshot doc in qn.docs) {
      //   print("Document ID: ${doc.id}");
      //   print("NameSong: ${doc["nameSong"]}");
      //   print("Author: ${doc["author"]}");
      //   print("Song URL: ${doc["song"]}");
      //   print("Image URL: ${doc["image"]}");
      //   print("----------------------------------------");
      // }
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
      _songs.assignAll(
        qn.docs.map(
          (doc) => {
            "nameSong": doc["nameSong"],
            "song": doc["song"],
            "id": doc["id"],
            "image": doc["image"],
            "author": doc["author"],
          },
        ),
      );

      // add mp3 vào newplaylist để chạy nhạc
      final newPlaylist = ConcatenatingAudioSource(children: songs);
      print('Playlist AAAAAA ${newPlaylist.length}');
      // // Set the new playlist to the audioPlayer
      await audioPlayer.setAudioSource(newPlaylist);
      // Nếu có bài hát, cập nhật selectedSong với bài hát đầu tiên
    } catch (e) {
      print("Error fetching Songs: $e");
    }
  }
}
