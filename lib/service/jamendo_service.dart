import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_spotify_app/model/albums.dart';
import 'package:music_spotify_app/model/songJamgedo.dart';

class JamendoService {
  static const String clientId = '20cdc097';
  static const String apiUrl = 'https://api.jamendo.com/v3.0/albums';

  Future<List<Album>> fetchAlbums() async {
    try {
      // Gửi yêu cầu GET tới API Jamendo
      final response = await http.get(Uri.parse('$apiUrl?client_id=$clientId'));

      if (response.statusCode == 200) {
        var responseJson = json.decode(response.body);

        // Kiểm tra xem kết quả có tồn tại và đảm bảo không null
        if (responseJson['results'] != null && responseJson['results'] is List) {
          List<dynamic> albumsJson = responseJson['results'];

          // Chuyển đổi mỗi album JSON thành một đối tượng Album
          return albumsJson.map((json) => Album.fromJson(json)).toList();
        } else {
          throw Exception('Không có album nào được trả về hoặc dữ liệu không đúng định dạng.');
        }
      } else {
        throw Exception('Lỗi khi lấy album, mã trạng thái: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Lỗi khi lấy dữ liệu từ API: $e');
    }
  }

  // Future<List<SongJamedo>> fetchSongsByAlbumId(String albumId) async {
  //   const String tracksUrl = 'https://api.jamendo.com/v3.0/tracks';

  //   try {
  //     final response = await http.get(Uri.parse('$tracksUrl?client_id=$clientId&album_id=$albumId'));
  //     print('Response: ${response.body}');
  //     if (response.statusCode == 200) {
  //       var responseJson = json.decode(response.body);

  //       if (responseJson['results'] != null && responseJson['results'] is List) {
  //         List<dynamic> songsJson = responseJson['results'];
  //         return songsJson.map((json) => SongJamedo.fromJson(json)).toList();
  //       } else {
  //         throw Exception('Không có bài hát nào được trả về hoặc dữ liệu không đúng định dạng.');
  //       }
  //     } else {
  //       throw Exception('Lỗi khi lấy bài hát, mã trạng thái: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Lỗi khi lấy dữ liệu từ API: $e');
  //   }
  // }
  Future<List<SongJamedo>> fetchSongsByAlbumId(String albumId) async {
  const String tracksUrl = 'https://api.jamendo.com/v3.0/tracks';

  try {
    final response = await http.get(Uri.parse('$tracksUrl?client_id=$clientId&album_id=$albumId'));
    print('Response: ${response.body}'); // Log phản hồi của API để kiểm tra dữ liệu trả về

    if (response.statusCode == 200) {
      var responseJson = json.decode(response.body);

      // Kiểm tra xem dữ liệu có kết quả bài hát hay không
      if (responseJson['results'] != null && responseJson['results'] is List) {
        List<dynamic> songsJson = responseJson['results'];
        
        // Log dữ liệu của từng bài hát để kiểm tra từng trường dữ liệu
        songsJson.forEach((songJson) {
          print('Song data: $songJson'); // Log chi tiết mỗi bài hát
        });

        return songsJson.map((json) => SongJamedo.fromJson(json)).toList();
      } else {
        throw Exception('Không có bài hát nào được trả về hoặc dữ liệu không đúng định dạng.');
      }
    } else {
      throw Exception('Lỗi khi lấy bài hát, mã trạng thái: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Lỗi khi lấy dữ liệu từ API: $e');
  }
}

  Future<List<Map<String, dynamic>>> fetchJamendoSongs() async {
    try {
      final response = await http.get(
        Uri.parse('https://api.jamendo.com/v3.0/tracks?client_id=$clientId&limit=10')
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        List<Map<String, dynamic>> songs = [];
        for (var track in data['results']) {
          songs.add({
            'nameSong': track['name'],
            'author': track['artist_name'],
            'song': track['url'],
            'image': track['cover'],
          });
        }
        return songs;
      } else {
        throw Exception('Failed to load Jamendo songs');
      }
    } catch (e) {
      print('Error fetching songs from Jamendo: $e');
      return [];
    }
  }
  //lấy api đề xuất 
  Future<List<dynamic>> fetchTracksByMood(String mood) async {
    final url = Uri.parse(
        'https://api.jamendo.com/v3.0/tracks?client_id=$clientId&tags=mood:$mood');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Failed to load tracks');
    }
  }
  // Future<List<Map<String, dynamic>>> fetchJamendoSongs() async {
  //   try {
  //     int offset = 0;
  //     int limit = 10;
  //     List<Map<String, dynamic>> songs = [];

  //     while (true) {
  //       final response = await http.get(
  //         Uri.parse('https://api.jamendo.com/v3.0/tracks?client_id=$clientId&limit=$limit&offset=$offset')
  //       );

  //       if (response.statusCode == 200) {
  //         final data = jsonDecode(response.body);
  //         for (var track in data['results']) {
  //           songs.add({
  //             'nameSong': track['name'],
  //             'author': track['artist_name'],
  //             'song': track['url'],
  //             'image': track['cover'],
  //           });
  //         }

  //         if (data['headers']['total'] <= offset + limit) {
  //           break;
  //         }

  //         offset += limit;
  //       } else {
  //         throw Exception('Failed to load Jamendo songs');
  //       }
  //     }

  //     return songs;
  //   } catch (e) {
  //     print('Error fetching songs from Jamendo: $e');
  //     return [];
  //   }
  // }
}
