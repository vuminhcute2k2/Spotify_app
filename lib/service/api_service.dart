import 'dart:convert';
import 'package:http/http.dart' as http;

// Hàm gửi dữ liệu văn bản để phân tích tâm trạng và nhận danh sách album
Future<List<dynamic>> analyzeMoodAndFetchAlbums(String userMood) async {
  final apiUrl = 'https://4a53-118-70-184-62.ngrok-free.app/recommend_albums';

  try {
    // Gửi dữ liệu đến API
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'mood': userMood}), // Dữ liệu bạn gửi
    );

    // Kiểm tra trạng thái phản hồi
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['albums']; // Trả về danh sách album
    } else {
      throw Exception('Failed to fetch albums. Error: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
