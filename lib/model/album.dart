// class Album {
//   final String name;
//   final String imageUrl;
//   final String artistName;

//   Album({
//     required this.name,
//     required this.imageUrl,
//     required this.artistName,
//   });

//   // Hàm factory để tạo Album từ JSON trả về từ Spotify API
//   factory Album.fromJson(Map<String, dynamic> json) {
//     return Album(
//       name: json['name'],
//       imageUrl: json['images'][0]['url'], // Lấy ảnh đầu tiên trong danh sách ảnh của album
//       artistName: json['artists'][0]['name'], // Lấy tên nghệ sĩ đầu tiên
//     );
//   }
// }
