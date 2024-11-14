import 'dart:convert';

import 'package:http/http.dart' as http;
class SpotifyApi {
  final String clientId = 'ff6dfa31695249239b64551801a0d7a6';
  final String clientSecret = 'ec2461c95b2644ae8df27180db9876ad';
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
      return jsonData['access_token'];
    } else {
      return null;
    }
  }
}