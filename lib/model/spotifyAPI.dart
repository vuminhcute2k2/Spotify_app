import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class SpotifyApi {
  final String clientId = 'ff6dfa31695249239b64551801a0d7a6';
  final String clientSecret = 'ec2461c95b2644ae8df27180db9876ad';
  final String tokenUrl = 'https://accounts.spotify.com/api/token';
  final String apiUrl = 'https://api.spotify.com/v1';
  String? _accessToken;
  late AudioPlayer audioPlayer;
  Future<String?> getAccessToken(String code) async {
    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': 'http://localhost:8080/callback',
        'client_id': clientId,
        'client_secret': clientSecret,
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      _accessToken = jsonData['access_token'];
      return _accessToken;
      // return jsonData['access_token'];
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> getTrack(
      String trackId, String accessToken) async {
    final response = await http.get(
      Uri.parse('$apiUrl/tracks/$trackId'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to load track');
    }
  }

  Future<void> playMusicFromSpotify(String songId,
      {String? albumId, required String code}) async {
    // Lấy access token
    final accessToken = await getAccessToken(code);

    if (albumId != null) {
      // Lấy dữ liệu về album từ Spotify API
      final response = await http.get(
          Uri.parse('https://api.spotify.com/v1/albums/$albumId'),
          headers: {
            'Authorization': 'Bearer $_accessToken',
          });

      final jsonData = jsonDecode(response.body);

      // Lấy danh sách bài hát của album
      final tracks = jsonData['tracks']['items'];

      // Tạo một danh sách AudioSource từ danh sách bài hát
      final audioSources = tracks.map((track) {
        return AudioSource.uri(
          Uri.parse(track['preview_url']),
          tag: MediaItem(
            id: track['id'],
            title: track['name'],
            artist: track['artists'][0]['name'],
            artUri: Uri.parse(track['album']['images'][0]['url']),
          ),
        );
      }).toList();

      // Phát nhạc
      await audioPlayer
          .setAudioSource(ConcatenatingAudioSource(children: audioSources));
      await audioPlayer.play();
    } else {
      // Lấy dữ liệu về bài hát từ Spotify API
      final response = await http.get(
          Uri.parse('https://api.spotify.com/v1/tracks/$songId'),
          headers: {
            'Authorization': 'Bearer $_accessToken',
          });

      final jsonData = jsonDecode(response.body);

      // Lấy URL của bài hát
      final songUrl = jsonData['preview_url'];

      // Phát nhạc
      await audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(songUrl)));
      await audioPlayer.play();
    }
  }
}
