import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_spotify_app/app/modules/musicpage/view/musicpage_screen.dart';
import 'package:music_spotify_app/model/songJamgedo.dart';
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

  //sử lý sự kiện thêm vào mục yêu tích <3
  var favoriteSongs = <String>[].obs;
  final Rx<Map<String, dynamic>> currentSongInfo = Rx<Map<String, dynamic>>({});
  // Biến chứa danh sách bài hát trong album
  RxList<AudioSource> albumPlaylist = <AudioSource>[].obs;

  @override
  void onInit() {
    super.onInit();
    audioPlayer = AudioPlayer();
    _init();
    // musicSongs();
    replayCurrentSong();
  }

  bool isFromFirebase(Map<String, dynamic> song) {
    return song.containsKey('song') && song.containsKey('nameSong');
  }

  bool isFromJamendo(Map<String, dynamic> song) {
    return song.containsKey('musicSongs') && song.containsKey('title');
  }

  // Cập nhật danh sách bài hát album khi chọn bài hát
  void updateAlbumPlaylist(List<Map<String, dynamic>> albumSongs) async {
    albumPlaylist.clear();
    List<AudioSource> audioSources = albumSongs.map((song) {
      return AudioSource.uri(
        Uri.parse(song['musicSongs']),
        tag: MediaItem(
          id: song['musicSongs'],
          title: song['title'],
          artist: song['artist'],
          artUri: Uri.parse(song['imageUrl']),
        ),
      );
    }).toList();

    albumPlaylist.addAll(audioSources);
    // Cập nhật lại playlist cho AudioPlayer
    await audioPlayer.setAudioSource(
      ConcatenatingAudioSource(children: albumPlaylist),
      initialIndex:
          0, // Đảm bảo bài hát đầu tiên được phát khi album được cập nhật
      initialPosition: Duration.zero,
    );

    // Đảm bảo phát nhạc ngay lập tức sau khi cập nhật playlist
    await audioPlayer.play();

    // Lắng nghe sự kiện chuyển bài
    audioPlayer.sequenceStateStream.listen((sequenceState) {
      if (sequenceState != null && sequenceState.currentIndex != null) {
        int currentIndex = sequenceState.currentIndex!;
        if (currentIndex + 1 < sequenceState.sequence.length) {
          // Chuyển đến bài hát tiếp theo trong danh sách
          audioPlayer.seekToNext();
        }
      }
    });
  }

  // void updateSelectedSong(Map<String, dynamic> song) async {
  //   currentSong.value = RxMap<String, dynamic>.from(song);

  //   if (isFromFirebase(song)) {
  //     // Xử lý nhạc từ Firebase
  //     final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //     QuerySnapshot qn = await _firestore.collection("today-songs").get();

  //     // Tạo danh sách các AudioSource từ các bài hát trong Firebase
  //     final List<AudioSource> songs = qn.docs.map((doc) {
  //       return AudioSource.uri(
  //         Uri.parse(doc["song"]),
  //         tag: MediaItem(
  //           id: doc["song"],
  //           title: doc["nameSong"],
  //           artist: doc["author"],
  //           artUri: Uri.parse(doc["image"]),
  //         ),
  //       );
  //     }).toList();

  //     // Tìm vị trí của bài hát đã chọn trong danh sách songs
  //     int indexOfSelectedSong = songs.indexWhere((source) {
  //       if (source is UriAudioSource) {
  //         return Uri.parse(song['song']) == source.uri;
  //       }
  //       return false;
  //     });

  //     // Tạo playlist mới từ danh sách bài hát và cập nhật vào AudioPlayer
  //     final newPlaylist = ConcatenatingAudioSource(children: songs);
  //     await audioPlayer.setAudioSource(newPlaylist,
  //         initialIndex: indexOfSelectedSong, initialPosition: Duration.zero);
  //   } else if (isFromJamendo(song)) {
  //     // Xử lý nhạc từ Jamendo
  //     final List<AudioSource> jamendoSongs = [
  //       AudioSource.uri(
  //         Uri.parse(song['musicSongs']),
  //         tag: MediaItem(
  //           id: song['musicSongs'],
  //           title: song['title'],
  //           artist: song['artist'],
  //           artUri: Uri.parse(song['imageUrl']),
  //         ),
  //       )
  //     ];

  //     // Tạo playlist mới từ bài hát trong Jamendo
  //     final newPlaylist = ConcatenatingAudioSource(children: jamendoSongs);
  //     await audioPlayer.setAudioSource(newPlaylist,
  //         initialIndex: 0, initialPosition: Duration.zero);
  //   } else {
  //     print('Cannot determine the source of the song.');
  //   }

  //   _songChangedController.add(null); // Notify listeners about song change
  // }
  void updateSelectedSong(Map<String, dynamic> song) async {
    currentSong.value = RxMap<String, dynamic>.from(song);
    if (isFromFirebase(song)) {
      // Xử lý nhạc từ Firebase
      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      QuerySnapshot qn = await _firestore.collection("today-songs").get();

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

      int indexOfSelectedSong = songs.indexWhere((source) {
        if (source is UriAudioSource) {
          return Uri.parse(song['song']) == source.uri;
        }
        return false;
      });

      final newPlaylist = ConcatenatingAudioSource(children: songs);
      await audioPlayer.setAudioSource(newPlaylist,
          initialIndex: indexOfSelectedSong, initialPosition: Duration.zero);
    } else if (isFromJamendo(song)) {
      // Xử lý nhạc từ Jamendo
      final List<AudioSource> jamendoSongs = [
        AudioSource.uri(
          Uri.parse(song['musicSongs']),
          tag: MediaItem(
            id: song['musicSongs'],
            title: song['title'],
            artist: song['artist'],
            artUri: Uri.parse(song['imageUrl']),
          ),
        )
      ];

      final newPlaylist = ConcatenatingAudioSource(children: jamendoSongs);
      await audioPlayer.setAudioSource(newPlaylist,
          initialIndex: 0, initialPosition: Duration.zero);
    } else {
      print('Cannot determine the source of the song.');
    }

    // Lưu bài hát vào lịch sử nghe nhạc
    await addSongToHistory(song);

    _songChangedController.add(null); // Notify listeners about song change
  }

  // Đoạn mã để cập nhật selectedSong khi chọn một bài hát mới
  void onSongSelected(Map<String, dynamic> song) {
    if (song['song'] != null && song['song'].toString().isNotEmpty) {
      updateSelectedSong(song);
      replayCurrentSong();
      Get.to(() => MusicPageScreen(songData: song));
    } else {
      print('Invalid song URL');
    }
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

  //hàm sử lý sự kiện yêu thích
  bool isFavorite(String songId) {
    return favoriteSongs.contains(songId);
  }

// Hàm lấy ID của người dùng hiện tại từ Firebase Authentication
  String getCurrentUserId() {
    // Kiểm tra xem người dùng đã đăng nhập chưa
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Nếu đã đăng nhập, trả về ID của người dùng
      return user.uid;
    } else {
      return 'unknown_user';
    }
  }

  //onclick thêm xóa bài hát yêu thích
  void toggleFavorites(String songId, Map<String, dynamic> songData) {
    if (isFavorite(songId)) {
      removeFromFavorites(songId);
      removeFromFavoritesOnFirebase(songData);
    } else {
      addToFavorites(songId);
      addToFavoritesOnFirebase(songData);
    }
  }

  // Hàm xóa bài hát khỏi danh sách yêu thích
  void removeFromFavorites(String songId) {
    favoriteSongs.remove(songId);
  }

  // Hàm thêm bài hát vào danh sách yêu thích
  void addToFavorites(String songId) {
    favoriteSongs.add(songId);
  }

  // Hàm xóa bài hát khỏi danh sách yêu thích trên Firebase
  void removeFromFavoritesOnFirebase(Map<String, dynamic> songData) async {
    try {
      String userId = getCurrentUserId();
      DocumentReference favoritesRef =
          FirebaseFirestore.instance.collection('favorites').doc(userId);
      await favoritesRef.update({
        'songs': FieldValue.arrayRemove([songData])
      });

      print('Removing from favorites on Firebase: $songData');
    } catch (e) {
      print('Error removing from favorites on Firebase: $e');
    }
  }

  // Hàm thêm bài hát vào danh sách yêu thích trên Firebase
  void addToFavoritesOnFirebase(Map<String, dynamic> songData) async {
    try {
      String userId = getCurrentUserId();
      DocumentReference favoritesRef =
          FirebaseFirestore.instance.collection('favorites').doc(userId);
      DocumentSnapshot playlistSnapshot = await favoritesRef.get();
      if (playlistSnapshot.exists) {
        // Nếu playlist đã tồn tại, cập nhật dữ liệu bài hát vào playlist
        await favoritesRef.update({
          'songs': FieldValue.arrayUnion([songData])
        });
      } else {
        // Nếu playlist chưa tồn tại, tạo mới playlist với bài hát đầu tiên
        await favoritesRef.set({
          'songs': [songData]
        });
      }

      print('Song added to playlist successfully.');
    } catch (e) {
      print('Error adding song to playlist: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getFavoriteSongsFromFirebase() async {
    try {
      String userId = getCurrentUserId();
      DocumentSnapshot favoritesSnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(userId)
          .get();

      if (favoritesSnapshot.exists) {
        List<Map<String, dynamic>> favoriteSongs =
            List<Map<String, dynamic>>.from(favoritesSnapshot['songs']);
        print('Favorite songs from Firebase: $favoriteSongs');
        return favoriteSongs;
      } else {
        print('No favorite songs found in Firebase.');
        return [];
      }
    } catch (e) {
      print('Error getting favorite songs from Firebase: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getFavoriteSongsDetails() async {
    try {
      return await getFavoriteSongsFromFirebase();
    } catch (e) {
      print('Error getting favorite songs details: $e');
      return [];
    }
  }

//hàm chạy nhạc cho phần playlist
  Future<void> playFavoriteSongs({Map<String, dynamic>? selectedSong}) async {
    try {
      // Lấy ID của người dùng hiện tại
      String userId = getCurrentUserId();

      DocumentSnapshot favoritesSnapshot = await FirebaseFirestore.instance
          .collection('favorites')
          .doc(userId)
          .get();

      if (favoritesSnapshot.exists) {
        // Lấy danh sách bài hát từ dữ liệu Firestore
        List<Map<String, dynamic>> favoriteSongs =
            List<Map<String, dynamic>>.from(favoritesSnapshot['songs']);

        // Chuyển dữ liệu thành danh sách AudioSource
        List<AudioSource> songs = favoriteSongs.map((song) {
          return AudioSource.uri(
            Uri.parse(song['musicSongs']),
            tag: MediaItem(
              id: song['musicSongs'],
              title: song['title'],
              artist: song['artist'],
              artUri: Uri.parse(song['imageUrl']),
            ),
          );
        }).toList();

        // Cập nhật trình phát nhạc với danh sách bài hát mới
        await audioPlayer
            .setAudioSource(ConcatenatingAudioSource(children: songs));

        if (selectedSong != null) {
          // Tìm vị trí của bài hát được chọn trong danh sách
          int indexOfSelectedSong = favoriteSongs.indexWhere(
              (song) => song['musicSongs'] == selectedSong['musicSongs']);

          // Nếu tìm thấy, chạy bài hát được chọn
          if (indexOfSelectedSong != -1) {
            await audioPlayer.seek(Duration.zero, index: indexOfSelectedSong);
            await audioPlayer.play();
          }
        } else {
          // Nếu không có bài hát được chọn, bắt đầu phát từ vị trí đầu tiên
          await audioPlayer.play();
        }
      } else {
        print('Không tìm thấy danh sách yêu thích cho người dùng hiện tại.');
      }
    } catch (e) {
      print('Lỗi khi phát nhạc từ danh sách yêu thích: $e');
    }
  }
  //hàm thêm bài hát vào lịch sử nghe nhạc 
//   Future<void> addSongToHistory(Map<String, dynamic> song) async {
//   try {
//     String userId = getCurrentUserId();

//     // Chuẩn bị dữ liệu bài hát
//     final historyItem = {
//       'userId': userId,
//       'title': song.containsKey('title') ? song['title'] : song['nameSong'],
//       'artist': song.containsKey('artist') ? song['artist'] : song['author'],
//       'imageUrl': song.containsKey('imageUrl') ? song['imageUrl'] : song['image'],
//       'playedAt': DateTime.now().toIso8601String(),
//     };

//     // Kiểm tra dữ liệu hợp lệ
//     if (historyItem['title'] != null && 
//         historyItem['artist'] != null && 
//         historyItem['imageUrl'] != null) {
      
//       // Kiểm tra xem bài hát đã tồn tại trong lịch sử chưa (dựa trên title và artist)
//       QuerySnapshot existingHistory = await FirebaseFirestore.instance
//           .collection('history')
//           .where('userId', isEqualTo: userId)
//           .where('title', isEqualTo: historyItem['title'])
//           .where('artist', isEqualTo: historyItem['artist'])
//           .get();

//       if (existingHistory.docs.isNotEmpty) {
//         // Nếu bài hát đã tồn tại, cập nhật thời gian "playedAt"
//         for (var doc in existingHistory.docs) {
//           await FirebaseFirestore.instance
//               .collection('history')
//               .doc(doc.id)
//               .update({'playedAt': historyItem['playedAt']});
//         }
//         print('Updated existing song in history: ${historyItem['title']}');
//       } else {
//         // Nếu bài hát chưa tồn tại, thêm mới vào lịch sử
//         await FirebaseFirestore.instance.collection('history').add(historyItem);
//         print('Added new song to history: ${historyItem['title']}');
//       }
//     } else {
//       print('Invalid song data: $historyItem');
//     }
//   } catch (e) {
//     print('Error adding song to history: $e');
//   }
// }
Future<void> addSongToHistory(Map<String, dynamic> song) async {
  try {
    // Lấy userId từ Firebase Authentication
    String userId = getCurrentUserId();

    // Chuẩn bị dữ liệu bài hát
    final historyItem = {
      'title': song.containsKey('title') ? song['title'] : song['nameSong'],
      'artist': song.containsKey('artist') ? song['artist'] : song['author'],
      'imageUrl': song.containsKey('imageUrl') ? song['imageUrl'] : song['image'],
      'playedAt': DateTime.now().toIso8601String(),
    };

    // Kiểm tra dữ liệu hợp lệ
    if (historyItem['title'] != null &&
        historyItem['artist'] != null &&
        historyItem['imageUrl'] != null) {
      
      // Tham chiếu subcollection 'history' của người dùng
      CollectionReference userHistory = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('history');

      // Kiểm tra xem bài hát đã tồn tại trong lịch sử chưa (dựa trên title và artist)
      QuerySnapshot existingHistory = await userHistory
          .where('title', isEqualTo: historyItem['title'])
          .where('artist', isEqualTo: historyItem['artist'])
          .get();

      if (existingHistory.docs.isNotEmpty) {
        // Nếu bài hát đã tồn tại, cập nhật thời gian "playedAt"
        for (var doc in existingHistory.docs) {
          await userHistory.doc(doc.id).update({'playedAt': historyItem['playedAt']});
        }
        print('Updated existing song in history: ${historyItem['title']}');
      } else {
        // Nếu bài hát chưa tồn tại, thêm mới vào lịch sử
        await userHistory.add(historyItem);
        print('Added new song to history: ${historyItem['title']}');
      }
    } else {
      print('Invalid song data: $historyItem');
    }
  } catch (e) {
    print('Error adding song to history: $e');
  }
}


} 