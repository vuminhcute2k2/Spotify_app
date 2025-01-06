class SongJamedo {
  final String name;
  final String artistName;
  final String cover; // Album image
  final String url; // Song audio URL

  SongJamedo({
    required this.name,
    required this.artistName,
    required this.cover,
    required this.url,
  });

  factory SongJamedo.fromJson(Map<String, dynamic> json) {
    return SongJamedo(
      name: json['name'] ?? '',
      artistName: json['artist_name'] ?? '', // Sửa từ 'artistName' thành 'artist_name' để phù hợp với dữ liệu API
      cover: json['album_image'] ?? '', // Dùng 'album_image' từ API
      url: json['audio'] ?? '', // Dùng 'audio' từ API
    );
  }
}
